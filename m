Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481793B8038
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 11:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhF3JpN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 05:45:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47566 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3JpN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 05:45:13 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53DDC2223B;
        Wed, 30 Jun 2021 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625046163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3MNoSLnXHqAMX3jqPxgl/njzLp8ToXYl4dULk/puSI=;
        b=XfyYwT5Qi1Ku2shGh7rKtTc077cKu4YiKz6Hkm6eA5BM9h8Cyz80261+7bD1msJ3HqlCN7
        9Rb8/wORqTX98zfvCfUhm0zX0bJ00n3IFJkAXKuzZOyEKD9nIrJ9VE1PILPZ0Tsy1TPzcG
        Qz0OZjdAnNscjQTuOi71viTOLYCvnGE=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2044311906;
        Wed, 30 Jun 2021 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625046163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3MNoSLnXHqAMX3jqPxgl/njzLp8ToXYl4dULk/puSI=;
        b=XfyYwT5Qi1Ku2shGh7rKtTc077cKu4YiKz6Hkm6eA5BM9h8Cyz80261+7bD1msJ3HqlCN7
        9Rb8/wORqTX98zfvCfUhm0zX0bJ00n3IFJkAXKuzZOyEKD9nIrJ9VE1PILPZ0Tsy1TPzcG
        Qz0OZjdAnNscjQTuOi71viTOLYCvnGE=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id jC7GBpM83GD1bAAALh3uQQ
        (envelope-from <mkoutny@suse.com>); Wed, 30 Jun 2021 09:42:43 +0000
Date:   Wed, 30 Jun 2021 11:42:41 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
Message-ID: <YNw8kRpT6R2emuhI@blackbook>
References: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
 <20210610173944.1203706-4-schatzberg.dan@gmail.com>
 <YNXvr81YFzbaTxCb@blackbook>
 <YNnZ7hIRIk9dJDry@dschatzberg-fedora-PC0Y6AEN>
 <YNr1TYfBwR/tEpEJ@blackbook>
 <YNsoNeQNMmdplmtp@dschatzberg-fedora-PC0Y6AEN>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d+pAxhfHeN1kdV+F"
Content-Disposition: inline
In-Reply-To: <YNsoNeQNMmdplmtp@dschatzberg-fedora-PC0Y6AEN>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--d+pAxhfHeN1kdV+F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 29, 2021 at 10:03:33AM -0400, Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> Hmm, perhaps I'm not understanding how the reference counting works,
> but my understanding is that we enter loop_queue_rq with presumably
> some code earlier holding a reference to the blkcg, we only need to
> acquire a reference sometime before returning from loop_queue_rq. The
> "window" between loop_queue_rq and loop_queue_work is all
> straight-line code so there's no possibility for the earlier code to
> get control back and drop the reference.

I don't say the current implementation is wrong, it just looked
suspicious to me when the css address is copied without taking the
reference.
The straight path is clear, I'm not sure about later invocations through
loop_workfn where the blkcg_css is accessed via the cmd->blkcg_css.

> Where would you suggest putting such a comment?

This is how I understand it:

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -996,6 +996,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
        rb_insert_color(&worker->rb_node, &lo->worker_tree);
 queue_work:
        if (worker) {
+               WARN_ON_ONCE(worker->blkcg_css != cmd->blkcg_css);
                /*
                 * We need to remove from the idle list here while
                 * holding the lock so that the idle timer doesn't
@@ -2106,6 +2107,8 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
        cmd->memcg_css = NULL;
 #ifdef CONFIG_BLK_CGROUP
        if (rq->bio && rq->bio->bi_blkg) {
+               /* reference to blkcg_css will be held by loop_worker (outlives
+                * cmd) or it is the eternal root css */
                cmd->blkcg_css = &bio_blkcg(rq->bio)->css;
 #ifdef CONFIG_MEMCG
                cmd->memcg_css =

(On further thoughts, maybe the blkcg_css reference isn't needed even in
the loop_worker if it can be reasoned that blkcg_css won't go away while
there's an outstanding rq.)

HTH,
Michal

--d+pAxhfHeN1kdV+F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmDcPI4ACgkQia1+riC5
qShVnw//Z/ZtMKu1mO3W3DY9zAZG/2xeZlqAQuz4x1tWnQOb/vdX3yqhyX0JcIjI
8e4a2pF5XnYaPJs8kRU+4T7uUsaX/9Xb/ZAxOfcJWVFNWOZ+lO6VtK5OJSFFldVB
SyZLb6mHnE4s5ZFGZOHVA8T9rK7oY4buwZL4LL7PCqu9gc3hMPrS9okHNjzrb5lU
QmXUS/SZue0mqSJayQudE54BZ3y9tqWDxoE68SZ83DsxbRomVnVQ8RKFlB/3CQLc
FtjRJ709budI1jnZ54H1O1LOlolRMT6eY+8+gcY9LCcTCWUFs5iRXCwOGzekOPED
e39Ts7/msQv5NeQpIYNA0IqbaNW4ooJPXCAO3NKqKCwmM8zaQk66MrVfqhzbY8+I
W2WXep5pC9+tUD/jRvWW+cb+A1RnoLQ9qhYQ1xT6My+Uiy4M1IZDSzz3zA8O+5pD
l9SjDIe2VCi31ERgx/5s6rANquPKRx6N5CjYoxtU/KXD4HorQFKEzxBovuGtytAs
bPGQSHHM8/Zulgk4lENFywYX8NpqxyB9cvZr9q4tybth5fqvZSV+EY08JqXoNarV
GmQ1qaORP+0S7xoPBo+2RQweG7lm5kWzAehl4+bQKZnIOTxqqeP2aKuvcd7oELKE
VNVS4tpqppXaC2rLpb7LleZoPL+Qq+du+7e8Czui0RaDkO0Cw4I=
=IVGr
-----END PGP SIGNATURE-----

--d+pAxhfHeN1kdV+F--
