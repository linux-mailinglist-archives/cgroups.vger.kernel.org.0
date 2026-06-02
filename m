Return-Path: <cgroups+bounces-16576-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wIwVMu4JH2pheAAAu9opvQ
	(envelope-from <cgroups+bounces-16576-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 18:50:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B10630637
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 18:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ppi/jrKf";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16576-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16576-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD1C1304E249
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8536D37754C;
	Tue,  2 Jun 2026 16:44:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034D377ED4
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 16:44:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418679; cv=pass; b=SoNs6RB5Xu4BQJLnfqyCND2+kew8KUWw9LOfzDSj2g5W6fPvHHdcu+fSqKU2Dk1CMNz1CdB4QWeC4EPnQg3fC9ZRIHtAttX40NJIo+or+svgO1r/uAPI7ptE0IwUGZoVQZiH29XOy1tv8+wQrpVI5x3rUnUXx5DFspn9KAXQYn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418679; c=relaxed/simple;
	bh=H4X7GafgGytW9rIihOEjdmCsRPquH699r4PT+HiQB7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKdxaU/DO7UYTOHjlePy3ZmZK8YGaCjy3LxztN8qF1Di8OIjG+6N5rcCGdNvSx7bMm5eD+9Yk666oayqGTbUFqgN4hF/PTTlIxFTjHuBw61f0YZWkwoFjFsw5M0yNf3eGdvaEVvyKnwFINzfLQoEsKj2G3vKw2Jvhy5LKMhf1uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppi/jrKf; arc=pass smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8585cd8400so1288189a12.3
        for <cgroups@vger.kernel.org>; Tue, 02 Jun 2026 09:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780418677; cv=none;
        d=google.com; s=arc-20240605;
        b=HiyDIFe4sIUTh7j45gpzv8uanUPpx/lqfXFzjkkogEnmwIeDlSF5V5JRLOflnH5B3q
         H5uWgh7Qchfo7qpK3LFcX48Wxb43A5Olf0RSgwOFrqx4uxpbIP2lphcJeJL1PKNANN+6
         DOZrnA/FoYfDCzMzZcFzIGxCsot25N+sxf8bSVXBMNY1bsLZloZqAVVt+9cWSXzXXL0S
         uWfb8FeYB+wT245pKH11FNS+xuBr3iQcomjYGXFeea+Vcb8tNh1qekA+taMnmkXKN0ET
         e2jjtt+orb0YBY84dntM50Pz+sHlf2SPsCySexdFXqsdIB6tsiH8wfjWTYIYVdFNUhH5
         CLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H4X7GafgGytW9rIihOEjdmCsRPquH699r4PT+HiQB7M=;
        fh=wmI1BK3DS5qpoX1SEa177TCcVhknXItNm3jZUMeiSqo=;
        b=Ss6Zfr0l1yuFAzXvnJstFn2jGxm8RMIP3bLQWxgOFz5BKMWCB/CXehPADHrwLZTcMk
         N/Plr/dGoeaW03YqaabnOcsjJ152A2fyI2LezwEkt9R+2wlh3B2/MjcBRQA2Xx65oGAx
         RXKqoRj9do1HTSqqwe6cTJWJ5JLYCH2w/gUjpEp0OBKaHVVWkBEJ7nwHw4E9NEdW/U3M
         9Laeo291Chq0GBMwS4inDvCGJI0RZqwdQpNLEzE+Nq6d2fpqWae5pjLfZ73t5nWsrHrM
         WLAGkWiP2+HKwJ825DcSWZvdPjQJ6VfGpvPj4K+iSVpbKt+/AuWSo13VpvORlyhFcHnr
         NEdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780418677; x=1781023477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4X7GafgGytW9rIihOEjdmCsRPquH699r4PT+HiQB7M=;
        b=ppi/jrKfOL59yBlSgV/mzfyMMEo6/wlQzrVz3mWujwKAMVra2qy9ZxGdgblK0HWA8K
         QBKbmwyh974w+YqeO7q/waak2lHXMOhpwcmhj1BqH25d+swLdQIwarzWVjUuAYxPDi3Q
         5Q5y25KEs/AAZXqkLZ9onbDvOKKdqg9O47mDnMjRamDw+pa9yeikZbT/L7KBO0qYPuoK
         YhWRrAnQNfHMw8kSOoBFvQjFK/PxUPtJX9FeAjUtHpSEkMZKlA9eQzYs+Isn4w/4MuT4
         84XkL0N2Dqax2b0gostOJTWt8pf+y3mHLmiz+Suj834yVKgr89Fvfinj6HMMan25C275
         fFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418677; x=1781023477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H4X7GafgGytW9rIihOEjdmCsRPquH699r4PT+HiQB7M=;
        b=i6RKs+xQ3JJKzFK4cVmrLB5TsBQRu6mngblB3BTeUAPBBMuJzK5dbA8DrL3I5tcNdE
         NK+fBgqo/T3XWB/1fmdSFCcC3LQ/kpKUhdaympSwrF0L9fGedjj4PTI0XJQe+/nEvtmo
         wsXeGqLEgbP3IcrkrbhbQR8iMtQ9xhSbQwYt7HFyb4xZ4x5z6YW1gxMf/fixirFlLx1M
         wglzi+FeD4Uvi2jMIvCJV3kqOMvhL1RNUUtPLJtK5gPAqlQhsYp1jsFTVjbmixdarSmj
         SQlpBWyrgsP2ckAkOZc+60Pky6fRoVflntmD9gPoRBGLH4bQYtHurccYzXKZKsfe1xj6
         UU6w==
X-Forwarded-Encrypted: i=1; AFNElJ+RgIO1Y6lU1Oi3lw4tdR3YLQb7i2+3jCDlmGgi5RMLPQS07gNeYgZK41dEAbRKQdhnYMFwuEMu@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbFOtMPv5THwxyyVf9ydfr8ftE28I1z2qCmvpMLWlExEkHu3H
	P3LCDQtq2EAI+/MS/WR8SWnzh4g1TuFbFTUJdA/0SgNEAPAHuE+wREO1JI4v3ZGqgUXXsczUTgh
	dHEP4b3L43+jqxUppy51p26k4aBfo4rI=
X-Gm-Gg: Acq92OFO0ZWu2doK3uCFgN/+g5lbyg8OZ/gHrWkKpNcqZsAegyQKT3CWIj0W7wtjPal
	Lbg5SdQd27S950LvX1ZbN6402G6B/vQssSNpcPdT565owgd/ZS4EFFIVnNJhAxPmMjXhbiKlVsZ
	AdkdLgkJeh+UlYXN9stNYS5m0IOS+hJxm9KJGH6CnivjZrIjyfmI3F/v5y3mjWYQ7obmrkyL0ZK
	CTFNNwGqLZ7ig5spQ0WYye8TrGySHTP6YURaR6PI4swrpuaSEncfhZoPC/OLDxOBZiyXZpXemJP
	vRLrqjjCTiO/Xx0/7JaoL8EBKhD9gsRwyLs3hozwh1H4zRoD104=
X-Received: by 2002:a05:6a20:6a0f:b0:39b:dea7:5624 with SMTP id
 adf61e73a8af0-3b494703049mr283643637.47.1780418674638; Tue, 02 Jun 2026
 09:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
 <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com>
 <CAMgjq7CT0ccCnzmpRGjTGPnNEn4eK==5A-OFbr3+p465dQMH4A@mail.gmail.com> <CAKEwX=M3WAkSY=Zd35dEuQ6V3ZiNR02bKAN_DnCgVr69w9=0sQ@mail.gmail.com>
In-Reply-To: <CAKEwX=M3WAkSY=Zd35dEuQ6V3ZiNR02bKAN_DnCgVr69w9=0sQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 3 Jun 2026 00:43:56 +0800
X-Gm-Features: AVHnY4KpeXrvhgct7XamiE1lkAmJNELAfrV_3bpnCb4RsNbEUjdlDb9oJ5aU_SQ
Message-ID: <CAMgjq7DspvGR-2V6Go6tpCwBTWc9-pwK3WhMUoanWBAijmuypw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Nhat Pham <nphamcs@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16576-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:bhe@redhat.com,m:byungchul@sk.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:chrisl@kernel.org,m:corbet@lwn.net,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:hannes@cmpxchg.org,m:hughd@google.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:lenb@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:matthew.brost@intel.com,m:mhocko@suse.com,m:muchun.song@linux.dev,m:npache@redhat.com,m:pavel@kernel.org,m:peterx@redhat.com,m:peterz@infradead.org,m:pfalcato@suse.de,m:rafael@kernel.org,m:rakie.kim@sk.com,m:roman.gushchin@linux.dev,m:rppt@kernel.org,m:ryan.roberts@arm.com,m:shakeel.butt@linux.dev,m:shikemeng@huaweicloud.com,m:surenb@google.com,m:tg
 lx@kernel.org,m:vbabka@suse.cz,m:weixugc@google.com,m:ying.huang@linux.alibaba.com,m:yosry.ahmed@linux.dev,m:yuanchu@google.com,m:zhengqi.arch@bytedance.com,m:ziy@nvidia.com,m:kernel-team@meta.com,m:riel@surriel.com,m:haowenchao22@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40B10630637

On Tue, Jun 2, 2026 at 11:54=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Jun 1, 2026 at 10:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> >
> > That part should be indeed coverable by the si->percpu cluster though, =
I think.
>
> Yeah agree - we just need to be a bit craftier with it. The
> fundamental problem is in the current model, we're only storing offset
> and si, then look up cluster based on that. But for dynamic vswap,
> that look up takes the xa_load().
>
> Once we move to per-si per-cpu cluster, then I think it becomes ok to
> store the cluster pointer directly, correct?
>
> The reference counting needs to be carefully handled though. I think
> in my old vss design I did something fairly silly - just hold a
> reference to it while it's in cache, then add CPU offlining handler to
> clean up. Not the end of the world I suppose, but maybe there's a
> smarter scheme.

Yeah... I'm not entirely sure about this at this point, maybe it can
be sorted out as we process. Maybe we can also avoid the xa_load with
other techniques too.

