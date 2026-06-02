Return-Path: <cgroups+bounces-16572-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yBiqCgj4HmrYawAAu9opvQ
	(envelope-from <cgroups+bounces-16572-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 17:34:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C2D62FD0B
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 17:34:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=berkeley.edu header.s=google header.b=Yi5qBJOw;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16572-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16572-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=berkeley.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5671305C340
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5C83E9299;
	Tue,  2 Jun 2026 15:01:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDED3CE0BB
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 15:01:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412487; cv=pass; b=i2sTTwRJBv74URdPvtb1DugUGJmJv6FetVGe1uVUmo57kp7Efm2dteWWyBSN2Wqc1xYx+VWr9fJ2CpqWR/lNZ571Pfb683xgdsbyeniYvj5HOUOi87Ojq1bT+rZDD8yc2EPpSAxckUpMj4e4y7qaeDglj2gS3518KLWsfYWw4lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412487; c=relaxed/simple;
	bh=A39uLPUcRS9xs7E/cHbxTML9G26QUG3qveY/ZhElEDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFWR/k28cOLZNEx1df6ozgpDl7AcxSEzdDdHep4AyV+w7j2lZkn6IxQM9LR5gW+V7+KPWlOvUkIO6shTZhHxgDf/k2Yw/ZPij9cRtJpGmWokANb0yPdK6nQu/D+Osu3DjCYEvxrztA7QlohocKYoScaLxzQWqokJj8kFh2YERIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=Yi5qBJOw; arc=pass smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7e87602f26aso13914957b3.1
        for <cgroups@vger.kernel.org>; Tue, 02 Jun 2026 08:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780412484; cv=none;
        d=google.com; s=arc-20240605;
        b=GIHn+13R9n1nL56WRNGTAbaLH/qTE9cPzejP6HdQULRlfuI640y1i1r9vTm9mz33/J
         Ts8O7O9gfa5wDGk/AaFOtydeefUEXBNr3Np3CFhX3qgIe8nTULicTiwxQ4qDn/htdnUG
         s7jTmT3GatTfVcbrHlzETptibhOiFDtZL0ZttlWX5eMXFY3sUhCldoNia5OWIY9s7vUx
         9uNWLFOQkV4SyQHdO098XvcppDb4wfDkHl1CE3PVudFKwMQkntxpGqHaNW4QxzgB9HT3
         VIpKXbZf/m0qBy+sRKg5NLcQxAYlOddnOfgrAKDMTmt2uKbDoLglKDJ48LKL6ylJPifA
         Rd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2n1Z1p1zE/++mzakGGp7plWPOy4Oh6izK+XdQVDmCrg=;
        fh=c7Vp8n3b8lzp4t9OpUnOr3XdhWf+AS0y5YJhdFUKER8=;
        b=Oxqg+bOh87jFcTFF5+FkKuZD43FXEuisD7cAKL0A435ej7B5At++CSzr/K+JR7wvPp
         9FPtFFT58R7i+Y9W+OwUwTm1DeoYtdS+K7grBsFFI5b0O8yXvperCbzZVTKOA53cPOFn
         0HltEVSGnrZEGiwVWv7bWCJA9JDUt+eQ+hFytk8qn5TCAGAuK9I/96q9r2anIekFPB1l
         2F2GH/CZ9tsA3pmJ64ykr5wmDXb655dXA52w3WldwNsxoqsztkXwBtxbeBRLs8Tamoef
         w+ENHh7riD8CuTr5srCHinNZ9xgYxPa7bArvvA3GTxC110aAiimemjMZk42UzD3eYP6N
         ki7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1780412484; x=1781017284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2n1Z1p1zE/++mzakGGp7plWPOy4Oh6izK+XdQVDmCrg=;
        b=Yi5qBJOwtorlcArdQma//n6ZQeJDP5u9Fvw6RyELaTtgSZzrwIiXOEQ7K0/2Ss6R6I
         d9HejsiDNgRhuNF47fqcDBmh5byiUUQX5jiABrjNCySt8bNVD/2OvP8MIVBAoqkeqHRt
         Ca0VvSbxEYTzcWxjFsNjhFre2ohhNMSGjD5RYZdU6bHe1kMycu0JesdJeH+eGMSt5xdy
         INcca4hdZxH66n3asIlHSeb/Cc3JbQvsZLnUQbl+aoDljeXJX4MwvYs689M9sw002o3b
         Q8hXAyN277SD/glN8ZyJY6cukJ5l3K/VndGAK2Sffe/2OoJDMNzd7WWrXb/Zim3581rn
         7MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412484; x=1781017284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n1Z1p1zE/++mzakGGp7plWPOy4Oh6izK+XdQVDmCrg=;
        b=sC8YuSgkN1KZjbdGpvbZBRAKvZrWdvIwsHqVMKrGqlDhrLEKpqtzQslKdMOMIjou9q
         lLkf9vUyqWPNdrdAqJrRQg0U+UBjoEmXdCfua1kJ5L5ub+4ixH+vEJVviQTU0HADMzak
         KJh1BjCQrrPuCsAZWrLO6wP5LJ++9xpBr/PhY81nOnjD9nl5jSmyjZOYHyIECCCSb36w
         ZHpu349tu8j+YjGwPSUJ+rtGvsVz7muuOo1U8g8zhhCZ3hk3pC/OnMTd4KPZbTKlWGpW
         bYB3t22LzHt7c2vP1f7LsvA0zodRaJbosAPtEToFaEsKuvp5AMpXlVmkoyYrcG8WyTBo
         17LA==
X-Forwarded-Encrypted: i=1; AFNElJ/fj4Me0E21sBMev0nkuZFQtKrxgv54qejJsVZxTY33cMP9bRy5c05QXlbcfoL9phSP3jGe7JGt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzutv8ZTqKlK3bP7aF03ltXmskV5n9y47Ccv4xY3jkH4trdmkqS
	36TiPlsQB+CpalXhb0NirZW8cKKn4CmF0uCgzR5+pV7ULPFNFAHQud7pYidcI0qF59PCBDtE3iC
	XpC14tmtGSqE5J1h378zqo0NQWNvlS91kWHEePu3P
X-Gm-Gg: Acq92OGogBcSE86Y8INgpTwUlNSCWuYrQL4mv1UIVjvRQaRuQSDyfi+28DR71iRzMnl
	0GTpgJxczE5EO4ACFWsVLrpA7ntA9Eqw5Nom53+ynDL3YEzylQcqkhlJraaYOZyovfqFS+GHxTZ
	hVtWVVPuDVujmqycFNBmrPzep9c/02AtGZHwVB45DJU2fQ/errh3xvYFxUlmZDck9Mao+vHJF3d
	JPpRJFxPyk/W5Be1HOQvDv3uRhccWJfEu+Y7RNePo2JL5GBvwYklq6yXFgMWAlYQrUZ6MgiO8zl
	V4+ogOcL/LRwWHdHW9a/3cHEaG7dZDCcBAxBtY+jzh+sG/2SF54=
X-Received: by 2002:a05:690c:9b0b:b0:7ba:dcae:14dd with SMTP id
 00721157ae682-7e83c6bfa06mr40726327b3.19.1780412478962; Tue, 02 Jun 2026
 08:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528124133.c88c27b11a8ea0ef05e494f7@linux-foundation.org>
 <20260529152616.2308736-1-joshua.hahnjy@gmail.com> <ahnRIDBk4bQ3xX2q@yury>
 <fe33c767-ea11-43e2-8732-f752c9c1205c@kernel.org> <ah6X-RtVX75YP7VX@gourry-fedora-PF4VCD3F>
 <c98eb14d-b878-4eeb-91f0-d2b1d4407e1e@kernel.org> <ah6oS7wiGB4u4-eR@gourry-fedora-PF4VCD3F>
In-Reply-To: <ah6oS7wiGB4u4-eR@gourry-fedora-PF4VCD3F>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Tue, 2 Jun 2026 08:01:07 -0700
X-Gm-Features: AVHnY4JOgLxBTRoGJX0GhSA3-jleDuxY969AKZ4HYjUMghfMsszmyTDYa4YVtMY
Message-ID: <CA+0ovCiEz6SP_sn3kN4Tb+_oC=eHMXy_Ffj=usV3wREdQrUtww@mail.gmail.com>
Subject: Re: [PATCH] mm: don't allow empty relative nodemask in mpol_relative_nodemask()
To: Gregory Price <gourry@gourry.net>
Cc: falemi@asu.edu, "David Hildenbrand (Arm)" <david@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, cgroups@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005d93b306534695f4"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[berkeley.edu,reject];
	R_DKIM_ALLOW(-0.20)[berkeley.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:falemi@asu.edu,m:david@kernel.org,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:akpm@linux-foundation.org,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:longman@redhat.com,m:linux@rasmusvillemoes.dk,m:cgroups@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16572-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[farhad.alemi@berkeley.edu,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[berkeley.edu:+];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[farhad.alemi@berkeley.edu,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[asu.edu,kernel.org,nvidia.com,gmail.com,linux-foundation.org,intel.com,sk.com,linux.alibaba.com,kvack.org,vger.kernel.org,redhat.com,rasmusvillemoes.dk];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,gourry.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1C2D62FD0B

--0000000000005d93b306534695f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Confirmed, with a standalone reproducer (attached); it panics linus/master
at e8c2f9fdadee. cs->mems_allowed can legitimately be empty
on v2 -- a freshly created cpuset child that never had cpuset.mems
written keeps mems_allowed empty (never initialized) while effective_mems
is inherited non-empty in cpuset_css_online(), and v2 allows attaching
tasks to it (the empty-mems guard in cpuset_can_attach_check() is gated
on !is_in_v2_mode()). So the non-empty guarantee holds for effective_mems,
not for the configured cs->mems_allowed; forbidding empty cpuset.mems
would break v2's inherit-from-parent semantics.

The reproducer enables +cpuset, mkdirs a child without writing
cpuset.mems, moves a task in, mbind()s a VMA with
MPOL_BIND | MPOL_F_RELATIVE_NODES, and offlines a CPU; the hotplug walk
then calls mpol_rebind_mm(mm, &cs->mems_allowed) with the empty mask and
folds modulo nodes_weight(*rel) =3D=3D 0 (console logs attached).

The newmems instinct looks right: it's the effective, online mask the
task is actually allowed to use, guarantee_online_mems() keeps it
non-empty, and it matches cpuset_attach(), which already rebinds against
cs->effective_mems. The fix this implies:

  - mpol_rebind_mm(mm, &cs->mems_allowed);
  + mpol_rebind_mm(mm, &newmems);

I built the current base (e8c2f9fdadee) with and without this one-liner:
the unpatched kernel panics on the first cpu1 offline, while the patched
kernel runs the reproducer's 8 offline/online cycles cleanly, with no
divide error.

This regressed in ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}",
v3.17), which moved cpuset_attach() to the effective mask but left this
rebind on cs->mems_allowed.

Happy to send this as a proper patch (Fixes: ae1c802382f7, Cc: stable,
reproducer) if you agree the cpuset side is right, or to test a
mempolicy-side fix if not.


Thanks,

Farhad Alemi
PhD Student
SEFCOM Lab @ ASU

On Tue, Jun 2, 2026 at 2:54=E2=80=AFAM Gregory Price <gourry@gourry.net> wr=
ote:
>
> On Tue, Jun 02, 2026 at 11:19:49AM +0200, David Hildenbrand (Arm) wrote:
> >
> > According to the report [1] syzkaller can trigger it. There is no repro=
ducer,
> > though.
> >
> > [1]
> > https://lore.kernel.org/all/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+a=
fQBbGNmw@mail.gmail.com/
> >
>
> The actual implication of this report is that there is a bug in cpuset,
> not mempolicy.
>
>   mpol_rebind_mm+0x3ab/0x680 mm/mempolicy.c:569
>       ^^^ should never receive a 0-node nodemask ^^^
>   ...snip...
>   cpuset_update_tasks_nodemask+0x22e/0x340 kernel/cgroup/cpuset.c:2777
>       ^^^ calls guarantee_online_mems ^^^
>   ...snip...
>   hotplug_update_tasks kernel/cgroup/cpuset.c:3882 [inline]
>   cpuset_hotplug_update_tasks kernel/cgroup/cpuset.c:3985 [inline]
>
> Relevant code:
>
> void cpuset_update_tasks_nodemask(struct cpuset *cs)
> {
> ... snip ...
>         guarantee_online_mems(cs, &newmems); <<< critical call
> ... snip ...
>         while ((task =3D css_task_iter_next(&it))) {
> ... snip ...
>                 mpol_rebind_mm(mm, &cs->mems_allowed);
>
> Seems like maybe mpol_rebind_mm should be called with newmems, not
> cs->mems_allowed, though cs->mems_allowed should never be allowed to be
> empty, because that makes no sense.
>
> Just eyeballing it, I can't say whether calling with newmems is the
> right thing, or if mems_allowed should not be allowed to be empty, would
> have to dig in a little further.
>
> ~Gregory

--0000000000005d93b306534695f4
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mpwrc4p10>
X-Attachment-Id: f_mpwrc4p10

Ly8gUmVwcm9kdWNlciBmb3I6IGRpdmlkZSBlcnJvciBpbiBiaXRtYXBfZm9sZAovLyAgIChjcHVz
ZXQgaG90cGx1ZyByZWJpbmQgb2YgYSByZWxhdGl2ZS1ub2RlcyBtZW1wb2xpY3kgd2l0aCBhbiBl
bXB0eQovLyAgICBjcHVzZXQubWVtc19hbGxvd2VkKQovLwovLyBMb3JlIHJlcG9ydDoKLy8gICBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0ErMG92Q2d4YlprWGErT1U4dzNzODRSM0tOUE54
eFJmbXNOUi11ZGgrYWZRQmJHTm13QG1haWwuZ21haWwuY29tLwovLwovLyBDcmFzaCBzaWduYXR1
cmUgKFBJRCBpcyBhIGNwdWhwL04ga3RocmVhZCk6Ci8vICAgT29wczogZGl2aWRlIGVycm9yOiAw
MDAwIFsjMV0gLi4uIFJJUDogYml0bWFwX2ZvbGQrMHg1ZS8weGIwIGxpYi9iaXRtYXAuYzo3MjgK
Ly8gICBfX25vZGVzX2ZvbGQgaW5jbHVkZS9saW51eC9ub2RlbWFzay5oCi8vICAgbXBvbF9yZWxh
dGl2ZV9ub2RlbWFzayBtbS9tZW1wb2xpY3kuYzozNzQKLy8gICBtcG9sX3JlYmluZF9ub2RlbWFz
ayAgbW0vbWVtcG9saWN5LmM6NTExCi8vICAgbXBvbF9yZWJpbmRfcG9saWN5ICAgIG1tL21lbXBv
bGljeS5jOjU0NQovLyAgIG1wb2xfcmViaW5kX21tICAgICAgICBtbS9tZW1wb2xpY3kuYzo1NzIK
Ly8gICBjcHVzZXRfdXBkYXRlX3Rhc2tzX25vZGVtYXNrIGtlcm5lbC9jZ3JvdXAvY3B1c2V0LmM6
MjY1MgovLyAgIGhvdHBsdWdfdXBkYXRlX3Rhc2tzIC8gY3B1c2V0X2hvdHBsdWdfdXBkYXRlX3Rh
c2tzIC8gY3B1c2V0X2hhbmRsZV9ob3RwbHVnCi8vICAgY3B1c2V0X2NwdV9hY3RpdmV8aW5hY3Rp
dmUgLT4gc2NoZWRfY3B1X2FjdGl2YXRlfGRlYWN0aXZhdGUgKENQVSBob3RwbHVnKQovLwovLyBN
ZWNoYW5pc206Ci8vICAgMS4gQSBmcmVzaGx5IGNyZWF0ZWQgY2dyb3VwLXYyIGNwdXNldCBjaGls
ZCBoYXMgY3B1c2V0Lm1lbXNfYWxsb3dlZCA9PSB7fQovLyAgICAgIChuZXZlciB3cml0dGVuKSB3
aGlsZSBpdHMgZWZmZWN0aXZlX21lbXMgaXMgaW5oZXJpdGVkIGZyb20gdGhlIHBhcmVudAovLyAg
ICAgIGFuZCBpcyBub24tZW1wdHkuICBPbiB0aGUgbGVnYWN5ICh2MSkgaGllcmFyY2h5LCBjaGFu
Z2luZyBhIHBvcHVsYXRlZAovLyAgICAgIGNwdXNldCdzIG5vbi1lbXB0eSBjcHVzZXQubWVtcyB0
byBlbXB0eSBpcyByZWplY3RlZCAoLUVOT1NQQykgYnkgdGhlCi8vICAgICAgZW1wdHktbWVtcyBj
aGVjayBpbiBjcHVzZXQxX3ZhbGlkYXRlX2NoYW5nZSgpOyBvbiB0aGUgZGVmYXVsdCAodjIpCi8v
ICAgICAgaGllcmFyY2h5IHRoZXJlIGlzIG5vIHN1Y2ggY2hlY2ssIGFuZCBhIGZyZXNoIGNoaWxk
IHNpbXBseSBuZXZlcgovLyAgICAgIHdyaXRlcyBtZW1zX2FsbG93ZWQgYXQgYWxsLgovLyAgIDIu
IEEgdGFzayBpbiB0aGF0IGNoaWxkIG93bnMgYSBWTUEgbWVtcG9saWN5IGNyZWF0ZWQgd2l0aAov
LyAgICAgIE1QT0xfRl9SRUxBVElWRV9OT0RFUyBhbmQgYSBub24tZW1wdHkgdXNlciBub2RlbWFz
ay4KLy8gICAzLiBBIENQVSBob3R7LHVufXBsdWcgZXZlbnQgbWFrZXMgY3B1c2V0X2hhbmRsZV9o
b3RwbHVnKCkgd2FsayBldmVyeQovLyAgICAgIGRlc2NlbmRhbnQgKHRoZSB3YWxrIGlzIGdhdGVk
IG9uIHRoZSBhY3RpdmUgQ1BVL21lbSBzZXQgYWN0dWFsbHkKLy8gICAgICBjaGFuZ2luZywgd2hp
Y2ggYSBjcHUgb24vb2ZmbGluZSBzYXRpc2ZpZXMgdmlhIGNwdXNfdXBkYXRlZCkuICBGb3IgdGhl
Ci8vICAgICAgY2hpbGQsIG5ldyBlZmZlY3RpdmUgbWVtcyA9PSBvbGQsIGJ1dCB0aGUgdjIgaG90
cGx1ZyBwYXRoIHN0aWxsIGNhbGxzCi8vICAgICAgY3B1c2V0X3VwZGF0ZV90YXNrc19ub2RlbWFz
aygpLCB3aGljaCByZWJpbmRzIFZNQSBwb2xpY2llcyB3aXRoCi8vICAgICAgJmNzLT5tZW1zX2Fs
bG93ZWQgLS0gdGhlICpjb25maWd1cmVkKiAoZW1wdHkpIG1hc2ssIE5PVCB0aGUgZWZmZWN0aXZl
Ci8vICAgICAgb25lLgovLyAgIDQuIG1wb2xfcmViaW5kX25vZGVtYXNrKCkgc2VlcyBNUE9MX0Zf
UkVMQVRJVkVfTk9ERVMgYW5kIGNhbGxzCi8vICAgICAgbXBvbF9yZWxhdGl2ZV9ub2RlbWFzayh0
bXAsIHVzZXJfbm9kZW1hc2ssIGNzLT5tZW1zX2FsbG93ZWQ9e30pLCBpLmUuCi8vICAgICAgbm9k
ZXNfZm9sZCh0bXAsIHVzZXJfbm9kZW1hc2ssIG5vZGVzX3dlaWdodCh7fSk9PTApIC0+IGJpdG1h
cF9mb2xkKCkKLy8gICAgICB3aXRoIHN6PT0wIC0+IGBvbGRiaXQgJSAwYCAtPiAjREUuCi8vCi8v
IFJ1biBhcyByb290IGluc2lkZSB0aGUgdGVzdCBWTSAoa2VybmVsIENPTkZJR19IT1RQTFVHX0NQ
VSwgQ09ORklHX0NQVVNFVFMsCi8vIENPTkZJR19OVU1BKS4gIFRoZSBWTSBpbiB0aGUgcmVwb3J0
IGhhcyAtc21wIDIsIHNvIGNwdTEgaXMgb2ZmbGluZWQuCi8vCi8vICAgZ2NjIC1PMiAtc3RhdGlj
IC1vIHJlcHJvZHVjZXIgcmVwcm9kdWNlci5jICYmIC4vcmVwcm9kdWNlcgoKI2RlZmluZSBfR05V
X1NPVVJDRQojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxz
dGRpby5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5jbHVk
ZSA8c3lzL21vdW50Lmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgojaW5jbHVkZSA8c3lzL3N5c2Nh
bGwuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKI2RlZmluZSBNUE9MX0JJTkQgMgojZGVmaW5lIE1Q
T0xfRl9SRUxBVElWRV9OT0RFUyAoMSA8PCAxNCkKCnN0YXRpYyBpbnQgd3JpdGVfZmlsZShjb25z
dCBjaGFyICpwYXRoLCBjb25zdCBjaGFyICp2YWwpCnsKCWludCBmZCA9IG9wZW4ocGF0aCwgT19X
Uk9OTFkpOwoJaWYgKGZkIDwgMCkgewoJCWZwcmludGYoc3RkZXJyLCAiWy1dIG9wZW4oJXMpOiAl
c1xuIiwgcGF0aCwgc3RyZXJyb3IoZXJybm8pKTsKCQlyZXR1cm4gLTE7Cgl9CglpbnQgbiA9IHdy
aXRlKGZkLCB2YWwsIHN0cmxlbih2YWwpKTsKCWlmIChuIDwgMCkKCQlmcHJpbnRmKHN0ZGVyciwg
IlstXSB3cml0ZSglcywgXCIlc1wiKTogJXNcbiIsIHBhdGgsIHZhbCwKCQkJc3RyZXJyb3IoZXJy
bm8pKTsKCWNsb3NlKGZkKTsKCXJldHVybiBuIDwgMCA/IC0xIDogMDsKfQoKLy8gRmluZCBhIHdy
aXRhYmxlIGNncm91cDIgcm9vdCwgbW91bnRpbmcgYSBmcmVzaCB2aWV3IGlmIG5lZWRlZC4Kc3Rh
dGljIGNvbnN0IGNoYXIgKmNncm91cDJfcm9vdCh2b2lkKQp7CglzdGF0aWMgY2hhciByb290WzI1
Nl07CgoJLy8gQSBmcmVzaCBtb3VudCBvZiBjZ3JvdXAyIGlzIGp1c3QgYW5vdGhlciB2aWV3IG9m
IHRoZSBzaW5nbGUgdW5pZmllZAoJLy8gaGllcmFyY2h5LCBzbyBpdHMgcm9vdCBzdWJ0cmVlX2Nv
bnRyb2wgaXMgdGhlIHN5c3RlbSBvbmUuCglta2RpcigiL3RtcC9jZzIiLCAwNzU1KTsKCWlmICht
b3VudCgibm9uZSIsICIvdG1wL2NnMiIsICJjZ3JvdXAyIiwgMCwgTlVMTCkgPT0gMCB8fAoJICAg
IGVycm5vID09IEVCVVNZKSB7CgkJc3RyY3B5KHJvb3QsICIvdG1wL2NnMiIpOwoJCWlmIChhY2Nl
c3MoIi90bXAvY2cyL2Nncm91cC5zdWJ0cmVlX2NvbnRyb2wiLCBGX09LKSA9PSAwKQoJCQlyZXR1
cm4gcm9vdDsKCX0KCS8vIEZhbGwgYmFjayB0byB0aGUgY29udmVudGlvbmFsIGxvY2F0aW9uLgoJ
aWYgKGFjY2VzcygiL3N5cy9mcy9jZ3JvdXAvY2dyb3VwLnN1YnRyZWVfY29udHJvbCIsIEZfT0sp
ID09IDApIHsKCQlzdHJjcHkocm9vdCwgIi9zeXMvZnMvY2dyb3VwIik7CgkJcmV0dXJuIHJvb3Q7
Cgl9CglyZXR1cm4gTlVMTDsKfQoKaW50IG1haW4odm9pZCkKewoJY2hhciBwYXRoWzMyMF07CgoJ
Y29uc3QgY2hhciAqcm9vdCA9IGNncm91cDJfcm9vdCgpOwoJaWYgKCFyb290KSB7CgkJZnByaW50
ZihzdGRlcnIsICJbLV0gbm8gY2dyb3VwMiBoaWVyYXJjaHkgYXZhaWxhYmxlXG4iKTsKCQlyZXR1
cm4gMTsKCX0KCXByaW50ZigiWytdIGNncm91cDIgcm9vdDogJXNcbiIsIHJvb3QpOwoKCS8vIDEu
IEVuYWJsZSB0aGUgY3B1c2V0IGNvbnRyb2xsZXIgZm9yIGNoaWxkcmVuIG9mIHRoZSByb290LgoJ
c25wcmludGYocGF0aCwgc2l6ZW9mKHBhdGgpLCAiJXMvY2dyb3VwLnN1YnRyZWVfY29udHJvbCIs
IHJvb3QpOwoJd3JpdGVfZmlsZShwYXRoLCAiK2NwdXNldCIpOwoKCS8vIDIuIENyZWF0ZSBhIGNo
aWxkIGNwdXNldC4gIENydWNpYWxseSwgd2UgTkVWRVIgd3JpdGUgaXRzIGNwdXNldC5tZW1zLAoJ
Ly8gICAgc28gbWVtc19hbGxvd2VkIHN0YXlzIGVtcHR5IHdoaWxlIGVmZmVjdGl2ZV9tZW1zIGlu
aGVyaXRzIHswfS4KCXNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgIiVzL2tvb3BzIiwgcm9v
dCk7Cglta2RpcihwYXRoLCAwNzU1KTsKCgkvLyAzLiBNb3ZlIG91cnNlbHZlcyBpbnRvIHRoZSBj
aGlsZCAoYWxsb3dlZCBpbiB2MiBldmVuIHdpdGggZW1wdHkgbWVtcykuCglzbnByaW50ZihwYXRo
LCBzaXplb2YocGF0aCksICIlcy9rb29wcy9jZ3JvdXAucHJvY3MiLCByb290KTsKCWNoYXIgcGlk
WzMyXTsKCXNucHJpbnRmKHBpZCwgc2l6ZW9mKHBpZCksICIlZCIsIGdldHBpZCgpKTsKCWlmICh3
cml0ZV9maWxlKHBhdGgsIHBpZCkgPCAwKQoJCWZwcmludGYoc3RkZXJyLCAiWy1dIGNvdWxkIG5v
dCBqb2luIGNoaWxkIGNncm91cFxuIik7CgoJLy8gNC4gSW5zdGFsbCBhIFZNQSBtZW1wb2xpY3kg
d2l0aCBNUE9MX0ZfUkVMQVRJVkVfTk9ERVMgYW5kIGEgbm9uLWVtcHR5CgkvLyAgICB1c2VyIG5v
ZGVtYXNrIChub2RlIDApLiAgVGhpcyBpcyB0aGUgcG9saWN5IHdob3NlIGxhdGVyIHJlYmluZCB3
aXRoCgkvLyAgICBhbiBlbXB0eSBtYXNrIGZvbGRzIG1vZHVsbyB6ZXJvLgoJdm9pZCAqYXJlYSA9
IG1tYXAoTlVMTCwgMHg0MDAwLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLAoJCQkgIE1BUF9QUklW
QVRFIHwgTUFQX0FOT05ZTU9VUywgLTEsIDApOwoJaWYgKGFyZWEgPT0gTUFQX0ZBSUxFRCkgewoJ
CWZwcmludGYoc3RkZXJyLCAiWy1dIG1tYXA6ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOwoJCXJl
dHVybiAxOwoJfQoJdW5zaWduZWQgbG9uZyBub2RlbWFza1sxNl0gPSB7IDAgfTsKCW5vZGVtYXNr
WzBdID0gMVVMOyAvLyBub2RlIDAKCWxvbmcgciA9IHN5c2NhbGwoX19OUl9tYmluZCwgYXJlYSwg
MHg0MDAwLAoJCQkgTVBPTF9CSU5EIHwgTVBPTF9GX1JFTEFUSVZFX05PREVTLCBub2RlbWFzaywK
CQkJIHNpemVvZihub2RlbWFzaykgKiA4LCAwKTsKCWlmIChyICE9IDApCgkJZnByaW50ZihzdGRl
cnIsICJbLV0gbWJpbmQ6ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOwoJZWxzZQoJCXByaW50Zigi
WytdIGluc3RhbGxlZCBNUE9MX0ZfUkVMQVRJVkVfTk9ERVMgVk1BIHBvbGljeVxuIik7CgoJLy8g
NS4gVHJpZ2dlciBDUFUgaG90cGx1Zy4gIGNwdXNldF9oYW5kbGVfaG90cGx1ZygpIHRoZW4gd2Fs
a3MgZGVzY2VuZGFudHMKCS8vICAgIGFuZCByZWJpbmRzIG91ciBWTUEgcG9saWN5IHdpdGggdGhl
IGVtcHR5IG1lbXNfYWxsb3dlZCAtPiAjREUgaW4gdGhlCgkvLyAgICBjcHVocC9OIGt0aHJlYWQu
ICBMb29wIGEgZmV3IHRpbWVzIHRvIGNvdmVyIG9ubGluZS9vZmZsaW5lIHRpbWluZy4KCXByaW50
ZigiWytdIHRvZ2dsaW5nIGNwdTEgb25saW5lIHN0YXRlIHRvIHRyaWdnZXIgaG90cGx1ZyByZWJp
bmQuLi5cbiIpOwoJZm9yIChpbnQgaSA9IDA7IGkgPCA4OyBpKyspIHsKCQl3cml0ZV9maWxlKCIv
c3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUxL29ubGluZSIsICIwIik7CgkJd3JpdGVfZmlsZSgi
L3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MS9vbmxpbmUiLCAiMSIpOwoJfQoKCXByaW50Zigi
WytdIGRvbmUgKGlmIHRoZSBrZXJuZWwgZGlkIG5vdCBjcmFzaCwgY2hlY2sgTlVNQS9jcHVzZXQg
Y29uZmlnKVxuIik7CglyZXR1cm4gMDsKfQo=
--0000000000005d93b306534695f4--

