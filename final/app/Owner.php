<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Owner extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;
  public $table='owner';
  
  protected $casts=[
    'id_user'=>'integer',
    'id_auction'=>'integer',
  ];
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id_auction', 'id_user', 
    ];


  //protected $primaryKey = [ 'id_user', 'id_auction'];
  /**
   * The auction owner
   */
  public function user() {
    return $this->belongsTo('App\User','id_user', 'id_auction');
  }

  /**
   * Return id auction
   */
  public function auction() {
    return  $this->belongsTo('App\Auction','id_auction', 'id_user');
  }
}