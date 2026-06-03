Return-Path: <cgroups+bounces-16630-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6UDYNw6KIGpn4wAAu9opvQ
	(envelope-from <cgroups+bounces-16630-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 22:09:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5A163B0DF
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 22:09:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LmbRRXAk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16630-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16630-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C42B302C920
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7648D402B9C;
	Wed,  3 Jun 2026 20:09:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2303939C2
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 20:09:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517378; cv=pass; b=dThD1KtdvtqVxJWr8uiSg6ZhsO1kHfOIotNQgsVy2SOsOKhQHwrBuaDtU+lOF32FCjl8Xc9C+XovAm5VeWi9vwTAWZqQvK6X42pY4LS7+05jrKRCTbHlNb+z2Cs9gXxL4lcv3Sw99FG7B+E+Xi1pM5R7s9l+7AlN5hwvlpCl/oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517378; c=relaxed/simple;
	bh=5UXz52IyptNhzUMFPSnoxyMNWSpG1/iGAkBQWmQCJm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1rw3LkMdwgZb131ooJoTpCgGj34T7UIH6Tk4AHOyNnzuGOUtujwBIbrEptXrWHr/UlW+yFUKwN/msiMSFzy2C47D9aTDi4sOOJFUd9ifQQwATIPnT1UyTP7BBxJ/vsW2jSOY0biFv4a2OQLW9M12FiplHc3NvufnVTCzD+yul4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmbRRXAk; arc=pass smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso31492145e9.1
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 13:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780517375; cv=none;
        d=google.com; s=arc-20240605;
        b=IH2iDqAfRKvs9smAUfmz30fOEZO1hQmZ44eTrFW4TJ+tl3CxgxB3LcUtPUVF4h2eEP
         HXF86zcKlru68tWQ/N3hE9XnEXaN+8tVeaKOVwVKQv6PePbZnlJrazCZwXXIdX0LqWiC
         FUImocjYrwKRxOtGMP6DIe/g8uRd8EpJv0BGKXziN3FMfyzLhd0fIsoy3MyexrmTAiwV
         xidBAS+BqLPyn/dWrve4ZD0FrgB4q3J2NyKtRr+Jpm37/vLjc1+ym99Hh1Afsk3zKH/T
         bbh/J6BxZ137/GFGvw6t9SusT03iTaARdFKNIN8FQbjpF7tT7PVU75o+wGEpuTHu1ILu
         8fgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5UXz52IyptNhzUMFPSnoxyMNWSpG1/iGAkBQWmQCJm4=;
        fh=o2ZMUJmQUTSx0nrZCX+K5kSjt2y0o0c/A6b3CRqudP4=;
        b=Kco1+pE1q+eZUydlqkoNr0UCExrRsG+XfEQPAQ4/ozAYoUmPHSYZrO4MS+qVQoV8zT
         xeBv1VulC6skDmkDQT5Dlwc4DLt4zkMExYjAmT0XD6WjnVi/F7LdkwZ7pMtbEEwu6KFs
         WeE5GDuiZ3GQMR3DFfzCqA0bEQzvXIR2smHsTVg468ymJ8hUt5gMcBghgl9tvIuJU5uh
         cZRU6iYKLfYGnRIChLdqc694K9DEDAlEmDeXimQrHIAKNWeZ/bGjGHcbQgX0UHAMibwW
         DE+15FiXepTkxcOJLHOnmya9A/vSh8EEYjbKP1YKYG3GelMmcoM3mWwOvdZXgfwoN+mK
         yIvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780517375; x=1781122175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UXz52IyptNhzUMFPSnoxyMNWSpG1/iGAkBQWmQCJm4=;
        b=LmbRRXAkLTpoAGa8VXIvvPfH001QiN4fuiLeThJg7k63qQA0y7PWwUQxbOA1ZFnQ0Y
         7IH32jFtvRb9nM2W2Qp3ZEQLw2FFmyCrp69D3XBwt9l2Sdm/dm8Mj94V+KIZVgSh+x8z
         Yz3eUr/73iqamvTzMT9kWTqV+c1IOYKzLgeFdwMZWdq7Xp+l6+M2Shx8LJsa848eQtkj
         JFEQ7s+kw9CzXqZpwqs2qca4M/8arA6dLRRGES5ZjB1XAPdEoZ3GyaGL4JwtazRPVwNb
         Fc6DLLASWeEBDCbpZZ3OinB8Rnno8So4+VIyilrmODAPX3n7I8tO2ALCBgh513wY5otu
         bDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780517375; x=1781122175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UXz52IyptNhzUMFPSnoxyMNWSpG1/iGAkBQWmQCJm4=;
        b=cXrN3avpDsjDd63D04t/C2Nm3JfZY+rDUt6r3spGfTkk2nCFOMblno+aYFu2Vf4uqr
         YiNaMgNAnmu38HMdeWsXAL3Lu/mY7uX2VgQG29G4fIStUymnVCTFj6z1r/CBt6lGBGQo
         AYdgT3ubwxjl7sLEB5lhbCyyrdQXHQTXsVWyYoto2RVd0hJ+1/5dp9MLarm0quVATyUA
         0MQJoqlQvW10Rw9pNXFfmDSIYE8eNkncz2gFSVss/qbKrhHTrkgejfAqs3rstSTfDQCY
         cdvhV8ZJPMC/t+M0q/X/Q2cA/DQZ0jAdOWa9zg6yNihIhCT4Dvj8tjCb7Q+gD6NXz0sE
         9o7A==
X-Forwarded-Encrypted: i=1; AFNElJ/ueYitHr2zHm9X7ntr7kGe1+DVUvw7bWx1xT4bghNhkoWkY7qdOsSHbcXDYmQSMJbjC7YADXQV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oRMnKSl/aE7M2ObKdaizve1Y5TEZLvg48q2qMoQvLAtFsr52
	leGySRFALsFBVJT22zb42M9WbaFrnPq8tcDlMIh9Xth1qWJL2gFff2MXKbFKc1qPb2BlqKbH1EM
	xRR0JhXMm3tBN6lgj3L6wIv1qiq2C9sM=
X-Gm-Gg: Acq92OHAt6H/KZV+iE1K7wbzlP13MaBcydX9nIMLVdVxINf/nh35aJ7E1Dh+G25R2OD
	5J25lmtUpBykFUp7rnRX948BqnpiwJmUOZVSkVCLBXxT2bPgPGl5Rv+Ns9OwzUWM+Q2Tbh92Ja2
	2PX2LVvzZkAS0P1duwd5mer7JmyEcMPZsSrL4f7keZL5D5Oe8YQPdkLHl6cISv2IFWOGRMut+5d
	ZxcmOntF/ZGKmjBasDmnpP/ny3Xxl5mq1z1IkysyOi+e1MJdLMlxPhV6vGAJreed2YQq7engAp/
	3b3PzVi2dylzoIjYuZw/+EPuLQ9yFSMYAQ5jnAXbpaIVNG8vLA==
X-Received: by 2002:a05:600c:4fcc:b0:490:59cc:999f with SMTP id
 5b1f17b1804b1-490b5ea1016mr84902405e9.4.1780517375148; Wed, 03 Jun 2026
 13:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ah-A2gQ0GPgerXop@google.com>
 <CAKEwX=MWX9KkSFAoN4xEMg3b+gZUN9=yd7rirAWG5NOBf26eAg@mail.gmail.com>
 <aiB2sHqxcBAJrTkP@google.com> <CAKEwX=P95D7wNpWhEAXQpeNPM6eQa2mEZE8Srzfpct=-=Q40tg@mail.gmail.com>
 <CAO9r8zP+PkgRzXJcFv+3i2pKFQdLt78Ax1s1DY0qNaiUo7ySqA@mail.gmail.com>
In-Reply-To: <CAO9r8zP+PkgRzXJcFv+3i2pKFQdLt78Ax1s1DY0qNaiUo7ySqA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 3 Jun 2026 13:09:23 -0700
X-Gm-Features: AVHnY4JWxeOICXM6CH91NR0yRjpkfQjVY9j65WnUJqukjOXglYl_lhKm7GRZ5q4
Message-ID: <CAKEwX=M7zH=+83xeOnZcrHKt4jCo6hCB3qVLqWpfLquMcRbyUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Yosry Ahmed <yosry@kernel.org>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16630-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:kasong@tencent.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:bhe@redhat.com,m:byungchul@sk.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:chrisl@kernel.org,m:corbet@lwn.net,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:hannes@cmpxchg.org,m:hughd@google.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:lenb@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:matthew.brost@intel.com,m:mhocko@suse.com,m:muchun.song@linux.dev,m:npache@redhat.com,m:pavel@kernel.org,m:peterx@redhat.com,m:peterz@infradead.org,m:pfalcato@suse.de,m:rafael@kernel.org,m:rakie.kim@sk.com,m:roman.gushchin@linux.dev,m:rppt@kernel.org,m:ryan.roberts@arm.com,m:shakeel.butt@linux.dev,m:shikemeng@huaweicloud.com,m:su
 renb@google.com,m:tglx@kernel.org,m:vbabka@suse.cz,m:weixugc@google.com,m:ying.huang@linux.alibaba.com,m:yosry.ahmed@linux.dev,m:yuanchu@google.com,m:zhengqi.arch@bytedance.com,m:ziy@nvidia.com,m:kernel-team@meta.com,m:riel@surriel.com,m:haowenchao22@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D5A163B0DF

On Wed, Jun 3, 2026 at 12:35=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> > > > > All that being said, perhaps I am too out of touch with the code =
to
> > > > > realize it's simply not possible.
> > > > >
> > > > > Honestly, if the main reason we can't have a single swap table fo=
r vswap
> > > > > is saving 8 bytes on the reverse mapping, it sounds like a weak-i=
sh
> > > > > argument, even if we can't optimize the reverse mapping away. But=
 maybe
> > > > > I am also out of touch with RAM prices :)
> > > >
> > > > In terms of the space overhead I do agree, FWIW :)
> > > >
> > > > I think the other concern is the indirection overhead with going
> > > > through the xarray for every swap operation, hence the per-CPU vswa=
p
> > > > cluster lookup caching idea:
> > > >
> > > > https://lore.kernel.org/all/20260505153854.1612033-23-nphamcs@gmail=
.com/
> > >
> > > Right, but we should already avoid the xarray with the swap table
> > > design, right? We just have one swap table pointing to another
> > > essentially?
> >
> > Hmmm, I don't quite follow your suggestion here.
> >
> > For normal swap devices, we organize the space into clusters, and
> > maintain them in various lists (free, nonfull, full etc.). The only
> > difference with a vswap device is we do not have a free list, and have
> > the clusters themselves dynamically allocated.
> >
> > If we're using vswap, we will incur the xarray overhead. There's no
> > avoiding that if we want a dynamic indirection layer. We can of course
> > revisit this data structure design later.
> >
> > So yes, it will be one swap table (vswap cluster) pointing to another
> > swap table (pswap cluster). But to get to the first swap table, you
> > will have to go through xarray still.
>
> Why the xarray? Don't page tables (and shmem page cache) just point
> directly to the vswap entry the same way they point to swap entries
> today?
>
> *looks at the code*
>
> Oh, it's to find the actual cluster because the vswap file can be
> sparse? Hmm yeah I guess we can revisit the data structure here later,

Less sparsity, and more dynamicity :) It might be dense for all we
know - we just don't really know (or want to figure out) the size
statically.

> but IIRC xarrays aren't particularly good for sparse data. Maybe it's
> usually not sprase in practice.
>
> Maybe a maple tree? :)

Maybe :)

>
> > > > If folks like it, what I can do is have CONFIG_ZSWAP depends on
> > > > CONFIG_VSWAP, removes all the non-vswap logic, and call it a day? :=
)
> > > > Then, on the swap allocation side, if vswap allocation fail and zsw=
ap
> > > > writeback is disabled, we can error out early.
> > >
> > > Hmm maybe we can keep it around for now and do that after vswap
> > > stabilizes? It ultimately depend on how much complexity we maintain b=
y
> > > allowing both.
> > >
> > > I think another problem is 32-bit, technically zswap can be used on
> > > 32-bit now, right? So vswap not supporitng 32-bit is a problem.
> >
> > Ah shoot I forgot about that. Hmmm.
> >
> > It's not impossible to make vswap support 32-bit. I did that for v6
> > after all. It just needs extra fields because we have fewer bits to
> > leverage in pointers etc., complicating the logic a bit. Follow-up
> > work? :)
>
> Yeah we can do that, but it's a blocker for zswap only using vswap.

Yeah we can table that. FWIW, if you enable vswap, then zswap should
go through vswap already. It's just code complexity (hopefully for a
short while).

>
> > > General question (for both zswap and general swap code), would a boot
> > > param make implementation simpler? Right now we seem to key off the s=
wap
> > > device having the "vswap" flag, would it help if it was a runtime
> > > constant?
> >
> > Hmmm, even if it's a runtime constant, both branches still have to be
> > there, no? Does the boot param simplify it somehow?
>
> Maybe it doesn't simplify the code, but if the branching causes
> performance overhead we can use static keys. I guess we can still use
> static keys per-swapfile, but it would be more complicated.
>
> Anyway, not super important now.

Ahhh I see what you mean. Yeah we can optimize this later.

