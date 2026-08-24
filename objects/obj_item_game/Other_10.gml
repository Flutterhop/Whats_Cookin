
// Inherit the parent event
event_inherited();

function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){
		})
		.AddUpdate(function(){
			with(owner){
			}
	})
	.AddDraw(function(){
			with(owner){
					var state_name = struct.state_machine.GetStateName()
					scribble(state_name).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
			}
	});	
	var hold_state = new StatementState(struct.state_machine,"hold")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			with(owner){
			}
		})
	.AddDraw(function(){
			with(owner){
					var state_name = struct.state_machine.GetStateName()
					scribble(state_name).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
			}
	});
			
	struct.state_machine
	.AddState(idle_state)
	.AddState(hold_state)
	struct.state_machine.ChangeState("idle")
}
