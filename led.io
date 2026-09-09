(globals
        version = 3
        io_order = clockwise
        space = 2
        total_edge = 2
)

(iopad

        (topleft
                (inst name="CornerCell1"
                      cell=padIORINGCORNER
                      offset=0
                      orientation=R180
                      place_status=fixed)
        )

        (left

                (inst name="row0" cell=PADDO place_status=fixed)
                (inst name="row1" cell=PADDO place_status=fixed)
                (inst name="row2" cell=PADDO place_status=fixed)
                (inst name="row3" cell=PADDO place_status=fixed)
                (inst name="row4" cell=PADDO place_status=fixed)
                (inst name="row5" cell=PADDO place_status=fixed)
                (inst name="row6" cell=PADDO place_status=fixed)
                (inst name="row7" cell=PADDO place_status=fixed)

                (inst name="dd0"  cell=PADDI place_status=fixed)
                (inst name="dd1"  cell=PADDI place_status=fixed)
                (inst name="dd2"  cell=PADDI place_status=fixed)
                (inst name="dd3"  cell=PADDI place_status=fixed)
                (inst name="dd4"  cell=PADDI place_status=fixed)
                (inst name="dd5"  cell=PADDI place_status=fixed)
                (inst name="dd6"  cell=PADDI place_status=fixed)
                (inst name="dd7"  cell=PADDI place_status=fixed)
                (inst name="dd8"  cell=PADDI place_status=fixed)
                (inst name="dd9"  cell=PADDI place_status=fixed)
                (inst name="dd10" cell=PADDI place_status=fixed)
                (inst name="dd11" cell=PADDI place_status=fixed)
                (inst name="dd12" cell=PADDI place_status=fixed)
                (inst name="dd13" cell=PADDI place_status=fixed)
                (inst name="dd14" cell=PADDI place_status=fixed)

                (inst name="POWER_VDD01"
                      cell=PADVDD
                      place_status=fixed)

                (inst name="POWER_VSS01"
                      cell=PADVSS
                      place_status=fixed)
        )

        (topright
                (inst name="CornerCell2"
                      cell=padIORINGCORNER
                      offset=0
                      orientation=R90
                      place_status=fixed)
        )

        (top

                (inst name="c"
                      cell=PADDI
                      place_status=fixed)

                (inst name="r"
                      cell=PADDI
                      place_status=fixed)

                (inst name="dd15" cell=PADDI place_status=fixed)
                (inst name="dd16" cell=PADDI place_status=fixed)
                (inst name="dd17" cell=PADDI place_status=fixed)
                (inst name="dd18" cell=PADDI place_status=fixed)
                (inst name="dd19" cell=PADDI place_status=fixed)
                (inst name="dd20" cell=PADDI place_status=fixed)
                (inst name="dd21" cell=PADDI place_status=fixed)
                (inst name="dd22" cell=PADDI place_status=fixed)
                (inst name="dd23" cell=PADDI place_status=fixed)
                (inst name="dd24" cell=PADDI place_status=fixed)
                (inst name="dd25" cell=PADDI place_status=fixed)
                (inst name="dd26" cell=PADDI place_status=fixed)
                (inst name="dd27" cell=PADDI place_status=fixed)
                (inst name="dd28" cell=PADDI place_status=fixed)
                (inst name="dd29" cell=PADDI place_status=fixed)
                (inst name="dd30" cell=PADDI place_status=fixed)
                (inst name="dd31" cell=PADDI place_status=fixed)
                (inst name="dd32" cell=PADDI place_status=fixed)
                (inst name="dd33" cell=PADDI place_status=fixed)
                (inst name="dd34" cell=PADDI place_status=fixed)
                (inst name="dd35" cell=PADDI place_status=fixed)

                # 2 DUMMY PINS TO MAKE 25
                (inst name="dummy_pin_top0"
                      cell=PADDI
                      place_status=fixed)

                (inst name="dummy_pin_top1"
                      cell=PADDI
                      place_status=fixed)
        )

        (bottomright
                (inst name="CornerCell3"
                      cell=padIORINGCORNER
                      offset=0
                      orientation=R0
                      place_status=fixed)
        )

        (right

                (inst name="col0" cell=PADDO place_status=fixed)
                (inst name="col1" cell=PADDO place_status=fixed)
                (inst name="col2" cell=PADDO place_status=fixed)
                (inst name="col3" cell=PADDO place_status=fixed)
                (inst name="col4" cell=PADDO place_status=fixed)
                (inst name="col5" cell=PADDO place_status=fixed)
                (inst name="col6" cell=PADDO place_status=fixed)
                (inst name="col7" cell=PADDO place_status=fixed)

                (inst name="so"
                      cell=PADDO
                      place_status=fixed)

                (inst name="dd36" cell=PADDI place_status=fixed)
                (inst name="dd37" cell=PADDI place_status=fixed)
                (inst name="dd38" cell=PADDI place_status=fixed)
                (inst name="dd39" cell=PADDI place_status=fixed)
                (inst name="dd40" cell=PADDI place_status=fixed)
                (inst name="dd41" cell=PADDI place_status=fixed)
                (inst name="dd42" cell=PADDI place_status=fixed)
                (inst name="dd43" cell=PADDI place_status=fixed)
                (inst name="dd44" cell=PADDI place_status=fixed)
                (inst name="dd45" cell=PADDI place_status=fixed)
                (inst name="dd46" cell=PADDI place_status=fixed)
                (inst name="dd47" cell=PADDI place_status=fixed)
                (inst name="dd48" cell=PADDI place_status=fixed)

                # 3 DUMMY PINS TO MAKE 25
                (inst name="dummy_pin_right0"
                      cell=PADDI
                      place_status=fixed)

                (inst name="dummy_pin_right1"
                      cell=PADDI
                      place_status=fixed)

                (inst name="dummy_pin_right2"
                      cell=PADDI
                      place_status=fixed)

                # FILL CELL
                (inst name="dummy0"
                      cell=PADFILL
                      place_status=fixed)
        )

        (bottomleft
                (inst name="CornerCell4"
                      cell=padIORINGCORNER
                      offset=0
                      orientation=R270
                      place_status=fixed)
        )

               (bottom

                (inst name="dd49" cell=PADDI place_status=fixed)
                (inst name="dd50" cell=PADDI place_status=fixed)
                (inst name="dd51" cell=PADDI place_status=fixed)
                (inst name="dd52" cell=PADDI place_status=fixed)
                (inst name="dd53" cell=PADDI place_status=fixed)
                (inst name="dd54" cell=PADDI place_status=fixed)
                (inst name="dd55" cell=PADDI place_status=fixed)
                (inst name="dd56" cell=PADDI place_status=fixed)
                (inst name="dd57" cell=PADDI place_status=fixed)
                (inst name="dd58" cell=PADDI place_status=fixed)
                (inst name="dd59" cell=PADDI place_status=fixed)
                (inst name="dd60" cell=PADDI place_status=fixed)
                (inst name="dd61" cell=PADDI place_status=fixed)
                (inst name="dd62" cell=PADDI place_status=fixed)
                (inst name="dd63" cell=PADDI place_status=fixed)

                (inst name="b0" cell=PADDI place_status=fixed)
                (inst name="b1" cell=PADDI place_status=fixed)
                (inst name="b2" cell=PADDI place_status=fixed)
                (inst name="b3" cell=PADDI place_status=fixed)

                (inst name="se"
                      cell=PADDI
                      place_status=fixed)

                (inst name="si"
                      cell=PADDI
                      place_status=fixed)

                # 4 DUMMY PINS
                (inst name="dummy_pin_bottom0"
                      cell=PADDI
                      place_status=fixed)

                (inst name="dummy_pin_bottom1"
                      cell=PADDI
                      place_status=fixed)

                (inst name="dummy_pin_bottom2"
                      cell=PADDI
                      place_status=fixed)

                (inst name="dummy_pin_bottom3"
                      cell=PADDI
                      place_status=fixed)

                # FILL CELL
                (inst name="dummy1"
                      cell=PADFILL
                      place_status=fixed)
        )
)
