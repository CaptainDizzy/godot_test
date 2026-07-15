# DO THESE THINGS!
- Update/fix the hurt animation to make the player blink and get knocked back at the same time. Either through an Animation Tree or a function that causes the player to blink that's separated from the knockback effect, because using await also delays the knockback.

- Finish fully integrating the CharacterManager global script to include things more of the variables in the exceedingly large and growing variable list at the top of the player.gd

- Figure out why/how to fix being hurt during the first_landing sequence and splat animation makes the character sink below the floor a little bit.

- Either figure out how to get the moving platforms to push the player when they overlap, or just figure out a better way to position them so the top one doesn't collide into the player.

Next Steps:
- Make music for the platformer in the vein of Super Mario without being a blatant rip off. The intro fanfair bein similar is really all we need.
- Build out the space shooter (shmup)
- Get the basics of the adventure mechanics/style done
- Figure out what items or actions from the space shooter and the platformer can be tied into the adventure and how they help complete the game at large
- Make a main menu and in-game menu!

# Chicken Scratch:
- The space shooter will also be left to right like the platformer, and the adventure mape will just have to be much lower in the editor's global space; having the player teleport to its location after leaving the Fork Screen.

- How should we get things like hats or items or whatnot to attach to the player? a simple add node script should be fine, I think, but we need to think through it more completely.


__
| Thoughts For Future Updates:
--
- Add different levels to the the platformer and make them load at random or have the node progess to the next level after the player finishes the current one, keeping track of the ones that have been completed in the Fork Screen's text UI? ... Or maybe make the platformer procedurally generated?? <.<
