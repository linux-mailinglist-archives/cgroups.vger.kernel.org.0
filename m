Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2471F0DA
	for <lists+cgroups@lfdr.de>; Thu,  1 Jun 2023 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjFAReB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jun 2023 13:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjFAReA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jun 2023 13:34:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FFC137;
        Thu,  1 Jun 2023 10:33:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33F822198E;
        Thu,  1 Jun 2023 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685640835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhh+WbNovcJY32/ZmD2ytQlFKOEBfg7zTQ3V3+mleLM=;
        b=GyZM6g34CDsG/6yBK741e7b69x3H2uugU01hI+rOGMe7wMtff7G67jUvgZEDxMzZkPrlKv
        R0/EO0BxJu6AuNfIGHtebfrjDdJrMUUlKPP8+VDC+ByhCkxIauMW4XxDc9xuken5TUdtIX
        XyOn4MVb1gCRwmpMY9IzH9EFSJNA3rQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B30D139B7;
        Thu,  1 Jun 2023 17:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OCrIAYPWeGRXKQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 01 Jun 2023 17:33:55 +0000
Date:   Thu, 1 Jun 2023 19:33:53 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuigaosheng1@huawei.com
Subject: Re: [PATCH] cgroup: Stop task iteration when rebinding subsystem
Message-ID: <ojymhf4m3p52py6sezwbc2zamxm46wmhxs577uucima6evj2sc@djoi3dhzbdf6>
References: <20230526114139.70274-1-xiujianfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vmv26htnxfuy7rbb"
Content-Disposition: inline
In-Reply-To: <20230526114139.70274-1-xiujianfeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--vmv26htnxfuy7rbb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jianfeng.

On Fri, May 26, 2023 at 07:41:39PM +0800, Xiu Jianfeng <xiujianfeng@huaweic=
loud.com> wrote:
> The race that cause this bug can be shown as below:
>=20
> (hotplug cpu)                | (umount cpuset)
> mutex_lock(&cpuset_mutex)    | mutex_lock(&cgroup_mutex)
> cpuset_hotplug_workfn        |
>  rebuild_root_domains        |  rebind_subsystems
>   update_tasks_root_domain   |   spin_lock_irq(&css_set_lock)
>    css_task_iter_start       |    list_move_tail(&cset->e_cset_node[ss->i=
d]
>    while(css_task_iter_next) |                  &dcgrp->e_csets[ss->id]);
>    css_task_iter_end         |   spin_unlock_irq(&css_set_lock)
> mutex_unlock(&cpuset_mutex)  | mutex_unlock(&cgroup_mutex)

Good catch!

>=20
> Inside css_task_iter_start/next/end, css_set_lock is hold and then
> released, so when iterating task(left side), the css_set may be moved to
> another list(right side), then it->cset_head points to the old list head
> and it->cset_pos->next points to the head node of new list, which can't
> be used as struct css_set.

I find your analysis sane -- the stale it->cset_head is problematic.

> To fix this issue, introduce CSS_TASK_ITER_STOPPED flag for css_task_iter.
> when moving css_set to dcgrp->e_csets[ss->id] in rebind_subsystems(), stop
> the task iteration.

Does it mean that iteration would not yield all tasks that are
associated with give cs->css? That sounds like broken correctness of the
iterator.

I may suggest a slightly different approach that should not affect
running iterators.
- I had to switch from all css_sets to only scgrp's css_sets since
  css_set_table order of css_sets may be different than scgrp->e_csets
- Not sure how portable is using array element as a `member` argument of
  offsetof (in expansion of list_for_each_entry_safe).

This is only to illustrate the idea, i.e. merely compile tested.

WDYT?

Regards,
Michal

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 625d7483951c..e67d2a0776c1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1798,7 +1798,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u=
16 ss_mask)
 {
 	struct cgroup *dcgrp =3D &dst_root->cgrp;
 	struct cgroup_subsys *ss;
-	int ssid, i, ret;
+	int ssid, ret;
 	u16 dfl_disable_ss_mask =3D 0;
=20
 	lockdep_assert_held(&cgroup_mutex);
@@ -1842,7 +1842,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u=
16 ss_mask)
 		struct cgroup_root *src_root =3D ss->root;
 		struct cgroup *scgrp =3D &src_root->cgrp;
 		struct cgroup_subsys_state *css =3D cgroup_css(scgrp, ss);
-		struct css_set *cset;
+		struct css_set *cset, *cset_pos;
+		struct css_task_iter *it;
=20
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
=20
@@ -1860,9 +1861,18 @@ int rebind_subsystems(struct cgroup_root *dst_root, =
u16 ss_mask)
 		css->cgroup =3D dcgrp;
=20
 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id], e_cset=
_node[ss->id]) {
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+			/* all css_sets of scgrp together in same order to dcgrp,
+			 * patch in-flight iterators to preserve correct iteration,
+			 * cset_head is under css_set_lock */
+			list_for_each_entry(it, &cset->task_iters, iters_node) {
+				if (it->cset_head =3D=3D &scgrp->e_csets[ss->id])
+					it->cset_head =3D &dcgrp->e_csets[ss->id];
+			}
+		}
 		spin_unlock_irq(&css_set_lock);
=20
 		if (ss->css_rstat_flush) {

--vmv26htnxfuy7rbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZHjWfwAKCRAkDQmsBEOq
uYdwAP9NTo9oYu1o7d0GiJXma1Lp+QYKGqjf1QdRIHmnJu9FiQD6A6tMliFa6BqD
z89g4VthZWDKKSIs2NmvhIsqOsqXOww=
=rREO
-----END PGP SIGNATURE-----

--vmv26htnxfuy7rbb--
