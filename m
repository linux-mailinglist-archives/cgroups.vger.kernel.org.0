Return-Path: <cgroups+bounces-16976-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DFQfBoEpMGoPPQUAu9opvQ
	(envelope-from <cgroups+bounces-16976-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 18:34:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 688206886C3
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 18:34:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fnnas-com.20200927.dkim.feishu.cn header.s=s1 header.b="OeckO5/9";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16976-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16976-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B2F307ED9A
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A1E409E16;
	Mon, 15 Jun 2026 16:28:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from sg-3-28.ptr.tlmpb.com (sg-3-28.ptr.tlmpb.com [101.45.255.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D640B393
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 16:28:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540900; cv=none; b=OKh3pY8Wdpk0dlW1TH+O2EWGD5etU+IwHxSyv7ZKiuTHcq7dXXY9wrNmMQ/fposnbabOXfjEOIWj8owcAV/jjPH2FerD+o3+aerr4WG7f18WOhxk2ChrDugcwm2sg2PaI4OW2cfI0jxwDa91cPmbFSDrDYMGqLbFUoCbI0R/RF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540900; c=relaxed/simple;
	bh=4PeMgbEmobFrdGDlwf+b58+vlVlWUUifnljuI6GZ+CA=;
	h=From:Mime-Version:Content-Type:Subject:References:In-Reply-To:To:
	 Message-Id:Cc:Date; b=I6ViyFGTs/ypTsMMcBWANFuDC9bDKlmjqv1+i4oIz01DZp2wk5XR3+jQ3VI2faZ7FaZC9ntoctNbMnA/PjQVGHoJZMARQZghFPkszomtGbbSceCmksi2wTgApRdZ6pTv0MypQyxoSdHXPpFMjRk0IEnHvD8oe8r+p08i0/aJ38c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=OeckO5/9; arc=none smtp.client-ip=101.45.255.28
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1781540166;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=xNteM8cvm64RoqWOvtAwKvU/xR4tQhb/JI2DiVJ/Ki8=;
 b=OeckO5/97BDQ0ImBNRXaRd/eYxFJJh6FF7nrUt+nPi3/pN4yJe4zvB2SU4F45sXoWI+wGM
 Wyr+oEuNXO4Wi3AUoPLtqt589aEzIYCYIGlowqbXRwYF1q5wKlj3sbp7UjCPUuJR7i2ZYt
 91JPJDZ6oAPvOF9K3GqtCQ6+p1F7vFTmLEceohI1hIPxGp24CgfceLXvdooVffHfQs3pGb
 dNG/2f53+cnadF+idIxCBAzCBRdFKliVhokvVZdUVPceOL1wBvFssnTuADI4QFg4VadvJP
 Pzrt6cdYtAWzbRMvOB5rHmiIfn/KuTTSI851qhVKJdXrsZabx8V/kmWfoQfc5g==
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.180]) by smtp.feishu.cn with ESMTPS; Tue, 16 Jun 2026 00:16:03 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH V2] blk-cgroup: defer blkcg css_put until blkg is unlinked from queue
References: <20260615115556.1225472-1-wozizhi@huaweicloud.com>
In-Reply-To: <20260615115556.1225472-1-wozizhi@huaweicloud.com>
To: "Zizhi Wo" <wozizhi@huaweicloud.com>, <axboe@kernel.dk>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <linux-block@vger.kernel.org>
Message-Id: <70642ddf-9ed9-45cb-bf40-891a07247c97@fnnas.com>
X-Lms-Return-Path: <lba+26a302544+5a7ac8+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Cc: <cgroups@vger.kernel.org>, <yangerkun@huawei.com>, 
	<chengzhihao1@huawei.com>, <houtao1@huawei.com>, <yukuai@fygo.io>
Date: Tue, 16 Jun 2026 00:16:01 +0800
User-Agent: Mozilla Thunderbird
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:wozizhi@huaweicloud.com,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,m:houtao1@huawei.com,m:yukuai@fygo.io,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16976-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	HAS_REPLYTO(0.00)[yukuai@fygo.io];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:replyto,fygo.io:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fnnas-com.20200927.dkim.feishu.cn:dkim,fnnas.com:mid,fnnas.com:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 688206886C3

Hi=EF=BC=8C

=E5=9C=A8 2026/6/15 19:55, Zizhi Wo =E5=86=99=E9=81=93:
> From: Zizhi Wo <wozizhi@huawei.com>
>
> [BUG]
> Our fuzz testing triggered a blkcg use-after-free issue:
>
>    BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x75/0xe0
>    Call Trace:
>    ...
>    blkcg_deactivate_policy+0x244/0x4d0
>    ioc_rqos_exit+0x44/0xe0
>    rq_qos_exit+0xba/0x120
>    __del_gendisk+0x50b/0x800
>    del_gendisk+0xff/0x190
>    ...
>
> [CAUSE]
> process1						process2
> cgroup_rmdir
> ...
>    css_killed_work_fn
>      offline_css
>      ...
>        blkcg_destroy_blkgs
>        ...
>          __blkg_release
> 	  css_put(&blkg->blkcg->css)
>            blkg_free
> 	    INIT_WORK(xxx, blkg_free_workfn)
> 	    schedule_work
>      css_put
>      ...
>        blkcg_css_free
>          kfree(blkcg)--------blkcg has been freed!!!
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dschedule_work
>                blkg_free_workfn
> 							__del_gendisk
> 							  rq_qos_exit
> 							    ioc_rqos_exit
> 							      blkcg_deactivate_policy
> 							        mutex_lock(&q->blkcg_mutex)
> 								spin_lock_irq(&q->queue_lock)
> 							        list_for_each_entry(blkg, xxx)
> 								  blkcg =3D blkg->blkcg
> 								  spin_lock(&blkcg->lock)-------UAF!!!
> 	        mutex_lock(&q->blkcg_mutex)
> 	        spin_lock_irq(&q->queue_lock)
> 	        /* Only then is the blkg removed from the list */
> 	        list_del_init(&blkg->q_node)
>
> As a result, a blkg can still be reachable through q->blkg_list while
> its ->blkcg has already been freed.
>
> [Fix]
> Fix this by deferring the blkcg css_put() until after the blkg has been
> unlinked from q->blkg_list in blkg_free_workfn(). This ensures that the
> blkcg outlives every blkg still reachable through q->blkg_list, so any
> iterator holding q->queue_lock is guaranteed to observe a valid
> blkg->blkcg.
>
> While at it, move css_tryget_online() from blkg_create() into blkg_alloc(=
)
> so that the css reference is owned by the alloc/free pair rather than
> straddling layers:
> blkg_alloc()  <-> blkg_free()
> blkg_create() <-> blkg_destroy()
>
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free=
_workfn() and blkcg_deactivate_policy()")
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
> v2:
>   - Move css_tryget_online() from blkg_create() into blkg_alloc() so the
>     css reference follows the blkg's own lifetime, making the put in
>     blkg_free_workfn() symmetric with the get in blkg_alloc().
>
> v1: https://lore.kernel.org/all/20260518010932.633707-1-wozizhi@huaweiclo=
ud.com/
>
>   block/blk-cgroup.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bc63bd220865..27414c291e49 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -132,10 +132,15 @@ static void blkg_free_workfn(struct work_struct *wo=
rk)
>   	if (blkg->parent)
>   		blkg_put(blkg->parent);
>   	spin_lock_irq(&q->queue_lock);
>   	list_del_init(&blkg->q_node);
>   	spin_unlock_irq(&q->queue_lock);
> +	/*
> +	 * Release blkcg css ref only after blkg is removed from q->blkg_list,
> +	 * so concurrent iterators won't see a blkg with a freed blkcg.
> +	 */
> +	css_put(&blkg->blkcg->css);
>   	mutex_unlock(&q->blkcg_mutex);

Please move css_put after mutex_unlock, unless there is a strong reason.

With above change, feel free to add:

Reviewed-by: Yu Kuai <yukuai@fygo.io>

>  =20
>   	blk_put_queue(q);
>   	free_percpu(blkg->iostat_cpu);
>   	percpu_ref_exit(&blkg->refcnt);
> @@ -177,12 +182,10 @@ static void __blkg_release(struct rcu_head *rcu)
>   	 * blkg_stat_lock is for serializing blkg stat update
>   	 */
>   	for_each_possible_cpu(cpu)
>   		__blkcg_rstat_flush(blkcg, cpu);
>  =20
> -	/* release the blkcg and parent blkg refs this blkg has been holding */
> -	css_put(&blkg->blkcg->css);
>   	blkg_free(blkg);
>   }
>  =20
>   /*
>    * A group is RCU protected, but having an rcu lock does not mean that =
one
> @@ -311,10 +314,13 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *bl=
kcg, struct gendisk *disk,
>   	blkg->iostat_cpu =3D alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask=
);
>   	if (!blkg->iostat_cpu)
>   		goto out_exit_refcnt;
>   	if (!blk_get_queue(disk->queue))
>   		goto out_free_iostat;
> +	/* blkg holds a reference to blkcg */
> +	if (!css_tryget_online(&blkcg->css))
> +		goto out_put_queue;
>  =20
>   	blkg->q =3D disk->queue;
>   	INIT_LIST_HEAD(&blkg->q_node);
>   	blkg->blkcg =3D blkcg;
>   	blkg->iostat.blkg =3D blkg;
> @@ -351,10 +357,12 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *bl=
kcg, struct gendisk *disk,
>  =20
>   out_free_pds:
>   	while (--i >=3D 0)
>   		if (blkg->pd[i])
>   			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
> +	css_put(&blkcg->css);
> +out_put_queue:
>   	blk_put_queue(disk->queue);
>   out_free_iostat:
>   	free_percpu(blkg->iostat_cpu);
>   out_exit_refcnt:
>   	percpu_ref_exit(&blkg->refcnt);
> @@ -379,32 +387,26 @@ static struct blkcg_gq *blkg_create(struct blkcg *b=
lkcg, struct gendisk *disk,
>   	if (blk_queue_dying(disk->queue)) {
>   		ret =3D -ENODEV;
>   		goto err_free_blkg;
>   	}
>  =20
> -	/* blkg holds a reference to blkcg */
> -	if (!css_tryget_online(&blkcg->css)) {
> -		ret =3D -ENODEV;
> -		goto err_free_blkg;
> -	}
> -
>   	/* allocate */
>   	if (!new_blkg) {
>   		new_blkg =3D blkg_alloc(blkcg, disk, GFP_NOWAIT);
>   		if (unlikely(!new_blkg)) {
>   			ret =3D -ENOMEM;
> -			goto err_put_css;
> +			goto err_free_blkg;
>   		}
>   	}
>   	blkg =3D new_blkg;
>  =20
>   	/* link parent */
>   	if (blkcg_parent(blkcg)) {
>   		blkg->parent =3D blkg_lookup(blkcg_parent(blkcg), disk->queue);
>   		if (WARN_ON_ONCE(!blkg->parent)) {
>   			ret =3D -ENODEV;
> -			goto err_put_css;
> +			goto err_free_blkg;
>   		}
>   		blkg_get(blkg->parent);
>   	}
>  =20
>   	/* invoke per-policy init */
> @@ -440,12 +442,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *b=
lkcg, struct gendisk *disk,
>  =20
>   	/* @blkg failed fully initialized, use the usual release path */
>   	blkg_put(blkg);
>   	return ERR_PTR(ret);
>  =20
> -err_put_css:
> -	css_put(&blkcg->css);
>   err_free_blkg:
>   	if (new_blkg)
>   		blkg_free(new_blkg);
>   	return ERR_PTR(ret);
>   }

--=20
Thanks,
Kuai

