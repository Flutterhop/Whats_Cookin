event_inherited();
// Load audio groups
audio_group_load(audiogroup_music);
audio_group_load(audiogroup_sfx);

//NOTE:FOR NOW THE MAIN MENU LOADS TOO QUICK AND SO THE MAIN MENU MUSIC WONT LOAD IN TIME TO PLAY, SO IT IS IN THE DEFAULT GROUP

// Apply volume settings
audio_group_set_gain(audiogroup_default, musicVolume, 0);
audio_group_set_gain(audiogroup_music, musicVolume, 0);
audio_group_set_gain(audiogroup_sfx, sfxVolume, 0);

//Setting PER-TRACK gains manually (maybe there is a better way)
musicVolumeTable = ds_map_create();
musicVolumeTable[? fight_music] = 0.8;
musicVolumeTable[? victory_music] = 1.4;
musicVolumeTable[? bug_loop] = 0.9;
musicVolumeTable[? buggin_intro] = 2;
musicVolumeTable[? Buggin_Out_Fight_Music] = 1.4;
musicVolumeTable[? Buggin_Out_Shop_Theme] = 1.2;

// Tracking music playback
currentMusic = -1;
currentMusicRestart = false;
currentMusicFade = 1000;
currentMusicLoop = false;
currentMusicTimeSource = noone;
musicPosition = 0;
musicPaused = false;
base_gain = 1
pauseMusic = -1
//for debug purposes
currentMusicGain = 1

// Pause state
gamePaused = false;

sfxVolume = 1; //This needs to be added in settings

function play_music(_sound, _restart = false, _fade_time = 1000, _loop = true, _time_source = noone) {
    currentMusicAsset = _sound;
	currentMusicRestart = _restart;
	currentMusicFade = _fade_time;
	currentMusicLoop = _loop;
	currentMusicTimeSource = _time_source;
    currentMusic = audio_play_sound(_sound, 1, _loop);

    base_gain = get_music_base_gain(_sound);
    currentMusicGain = base_gain * (musicVolume / 10);

    // Start silent if fading in
    if (_fade_time > 0) {
        audio_sound_gain(currentMusic, 0, 0); // Instantly silent
        audio_sound_gain(currentMusic, currentMusicGain, _fade_time); // Fade to full volume
    } else {
        audio_sound_gain(currentMusic, currentMusicGain, 0);
    }

    // Set track position unless restarting
    if (!_restart) {
        audio_sound_set_track_position(currentMusic, musicPosition);
    }
}

function get_music_base_gain(_sound) {
    if (ds_map_exists(musicVolumeTable, _sound)) {
        return musicVolumeTable[? _sound];
    } else {
        return 1.0;
    }
}

function pause_music() {
    if (currentMusic != -1 && !musicPaused) {
        musicPosition = audio_sound_get_track_position(currentMusic);
        audio_stop_sound(currentMusic);
        musicPaused = true;
        
        pauseMusic = audio_play_sound(bug_loop, 1, true);
        audio_sound_gain(pauseMusic, get_music_base_gain(bug_loop) * (musicVolume / 10), 0);
    }
}

function resume_music() {
    if (musicPaused && currentMusic != -1) {
        if (pauseMusic != -1) {
            audio_stop_sound(pauseMusic);
            pauseMusic = -1;
        }
	play_music(currentMusicAsset, currentMusicRestart, currentMusicFade, currentMusicLoop, currentMusicTimeSource)
	musicPaused = false;
	}
}

function end_music() {
    if (currentMusic != -1) { 
		audio_stop_sound(currentMusic)
		currentMusic = -1;
    }
}


function toggle_pause() {
    gamePaused = !gamePaused;

    if (gamePaused) {
        pause_music();
        audio_group_set_gain(audiogroup_sfx, 0, 0); // Mute SFX while paused
    } else {
        resume_music();
        audio_group_set_gain(audiogroup_sfx, sfxVolume, 0);
    }
}

function play_sfx(_sound, _category = "low", _pitch = 1) {

    var priority;
    
    switch (_category) {
        case "high":
            priority = 100;
            break;
        case "medium":
            priority = 50;
            break;
        case "low":
        default:
            priority = 0;
            break;
    }
    
    var sfx = audio_play_sound(_sound, priority, false);
    audio_sound_gain(sfx, sfxVolume, 0);
    audio_sound_pitch(sfx, _pitch);
}

function update_music_volume(){
	var temp = musicVolume / 10;
	audio_group_set_gain(audiogroup_music, temp, 0);
}

function update_sfx_volume(){
	var temp = sfxVolume / 10;
	audio_group_set_gain(audiogroup_sfx, temp, 0);
}

function fade_music(_target_gain = 0, _fade_time = 1500) {
    if (currentMusic != -1) {
        audio_sound_gain(currentMusic, _target_gain, _fade_time);
    }
}