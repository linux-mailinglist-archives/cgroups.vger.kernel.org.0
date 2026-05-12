Return-Path: <cgroups+bounces-15810-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK5VJHW2AmrFvwEAu9opvQ
	(envelope-from <cgroups+bounces-15810-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 07:11:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23303519C2A
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 07:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1318F302DF41
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 05:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270DC3314AC;
	Tue, 12 May 2026 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P52gZt38"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54830E84B
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562661; cv=pass; b=MLnyU8qXL/ugDv2M3L61gauPRfxKKrtqerJj8efZl44/InIuBwRLxF+0RdzmM5vcXX7mV2OAx++bJKabMQblz+g4abCFxtqhBpt6Tb2oI9mUCFEYFq+QHkrf93zA9N8Bc3ftCMKHJEmjd+UnEiWkLfxBruRzneAcDsO6Xqt1Ulk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562661; c=relaxed/simple;
	bh=Z2ByQpr2vMVkBpLGJKthjYEMMIDYbAslC96sabfzflY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJuxlPOXmKCJw4MpvG45zWggExdaZncdRbHHSQdiPIwsFabQIzuuGSdijyKuOM+RpSmSQA3WswrVOBYccy5U2nk9ymbBHliS7NoqD9eKWtRaMF3Y1f8M7ataNSY8fK5Qk0yTSvtATLxltDwSXr0uxCJmxONs9Nxc5Zaz/IuLxu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P52gZt38; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd1caeba6beso14482266b.3
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 22:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778562659; cv=none;
        d=google.com; s=arc-20240605;
        b=YvvmS001QXOoAOKSuKHFBmniGoxplWLSMzQDIlZuuSRwG4MSHn7wedQqjinCGETo1c
         wAOCGZ9Nnhon5JDlp0uXVjBgj8G+XptU8RNCDEMpWOKkIZxXdOSeqA/cjBGqb/q8HU0H
         A4zbqXgCzG7+Pro6l39yVs3/TYNLa55HGW7fRw6PHSjg5OpNsFxR5gSvHTPE9XPeawXq
         aW7GBappe64lL19YPALRwWM4hE8H7d9vS5iLJXuN2TWy1v8W39XNKuS43mOPFkO8NKDL
         v4RE704nsgq+53XPMrxph9GoYqERkwEumRMtZB4/uk1O+n52e13IlFlNwphfMkfguZY0
         PvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BmFCwYFPN9JhQ7rUtUManCwqQCQkhjY68tukGiC0U4I=;
        fh=80Ii8ba71052ipBHj3io2yCi2loUipI2U5M6Qf3FtLY=;
        b=MCk7C7sjzKGqIJpZdib7Bbr9A41SgDwPlt1TaxRf+zCspscv/+KbDrw0h/ozuN0sPf
         2C/ai6l0XS6Mys39TCw13/LmoUQ2/4JqwwsTuwzevY5h6BedMW9kN3QfO41YCeUxGgeH
         7e3sern+jApw/c5Y2scA8Ay5Ri+5XmbfJuZOnwHbte/Nys2YxDyBi16wmqAs8h7OJg8h
         RFmQ+9Woy3UdwiSNgGSEASlIMJmiaBxi/aqQEvaFs/7yNMSfEY62r01GX5dgiRXjmbVT
         zpP7Ehop6sEez1flvMNAgtb8XS6ZX58lMyYVTAVjknRVfhZ6FIJQSLjiq1q0yuNRtDUd
         mDhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778562659; x=1779167459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmFCwYFPN9JhQ7rUtUManCwqQCQkhjY68tukGiC0U4I=;
        b=P52gZt38e3X0+0C1b49y12ajvoXeDfDXSFvr0R0Uus/IXmSryKEt/I0ZCBlqjcFzcF
         rW3A7xRXV8CNRufNLV1aSbPfSm2z27fnMkcdD8lUEgPzud9XGHWc8ci9RNVglfxnUX4t
         iQHKoMTerJP6amKTdV1rRHlGV3k/hPL0jj7d7dBJ27d5krr/URz8BvOt984r0WxL21sU
         OUWd91GoQ072+aZDLCkUZncbtEmtRVhdJhKcIL53F4gdKAbunRDlRr3wllZ+AxUkqQFy
         zE53vO3QMteRPbuZ2AB4IdWtHi9Im6aLuJwPicCvIql9SBfVHts5L2I3qPXVOpycmavf
         UIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778562659; x=1779167459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BmFCwYFPN9JhQ7rUtUManCwqQCQkhjY68tukGiC0U4I=;
        b=iDwhLfeWisxiM8mrWvuzom37BAnwtSkMKxA2pGV+kY/3egbD4carK4DzO38UGDZML5
         CxT06zwXTAWKcYdob4N5EulkH5BLsz27SimXsqh3J/O6MqApORzVQOHwcnte9X2lS9UY
         mcGzbWdoA6q0jzVHGS5c1YUmUDUQzsJUHnxLxEgssvZwZkrnWq8Jc3xHu6FgPu5HyxIv
         DfByCm+rcpBoMIB0zMbyi39NCATKscJrNLE1SD12KLTzhgXKCrx21sVJhuW8fAyoDyg+
         qpdz8z+LQoN1am1neiYY/48C1HIYbWABtODbclZeZvVxWRyRxKMx9Q1ggLUvlrbG5rWE
         1Xmw==
X-Forwarded-Encrypted: i=1; AFNElJ/EYjUY4AT3r/G01+7Gxn5baP1I+DLnsj9ZmkJ3YPkX6zOHOA4CGrZ9xRGIqXPtEh4bM+kND3ZJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMA2CQaiS1kUI3Zx3hT7fB/Twg2eh6EtekeoYtQBtg9zBuN80
	inVi3KCPafyK/SI41BxPo9yvLZJjLAkjkf84tHcNERe6faPjvNRXUcCZaiYwYGnhXI1Vqn6+FMy
	76f8U6zq1tTlhC4DfADQa0qjguTdFoao=
X-Gm-Gg: Acq92OH0gQHkmMGT64Do6d/djTw/aVhsyiUyTMijINHK5XZWjsWUVdlC8KzERI7QYoX
	EQ2Vb1UWKPeq8Vg1cpTbrrY/YpzM49iwZa+zZx53EQB3X/IQ3SwrsMwbq/JDPA7lEHNI9oXkGLd
	OKgUp0fnTzRpIU1vz6qodanPD8a5fOukbB9vdd5FYa8WDtal5wJCKaE00NVdUPmpCQeqj7t92Td
	K4tOzNsUU8ixPOB+sqUW5TYe3t/rt9bufUH1l4Yyp1cMVGB93y9ioLWhiZZGDwedslxmFQGrBCr
	5/8grrav+DyWUwZTxVPNbfOBdpmS74pp4LJ9yo8l
X-Received: by 2002:a17:907:9807:b0:ba7:cc67:488b with SMTP id
 a640c23a62f3a-bcaa9f61221mr914386766b.5.1778562658599; Mon, 11 May 2026
 22:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <CAMgjq7CJ8Are6m7X2UxUoJ=77c_oSpdG8-bzkmdRzwey2Cp1gQ@mail.gmail.com> <20260511141249.eac1426fee41c9fe463e7e23@linux-foundation.org>
In-Reply-To: <20260511141249.eac1426fee41c9fe463e7e23@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 12 May 2026 13:10:21 +0800
X-Gm-Features: AVHnY4Jyp38llNFierobB5C1VqdlwwSStVA5fOkuUPx0Tui9Rb1Ly3EEa2iHocM
Message-ID: <CAMgjq7DY5G_ZGYbDqnaqo3Uhr=FKi7OktzhmpzrWN+29=Q44+A@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm, swap: swap table phase IV: unify allocation
 and reduce static metadata
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 23303519C2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15810-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,linux-foundation.org:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 5:12=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 25 Apr 2026 02:11:47 +0800 Kairui Song <ryncsn@gmail.com> wrote:
> > I checked sashiko's review, it seems sashiko itself is bugged or
> > something wrong, Most patched end up with:
> > Tool error: Review tool timed out (active time exceeded)
> >
> > The rest of the results are all false positives, maybe I can add a few
> > more comments in the code or commit so it can understand the code
> > better.
> >
> > And checking V2's review:
> > https://sashiko.dev/#/patchset/20260417-swap-table-p4-v2-0-17f5d1015428=
%40tencent.com
> >
> > Which are mostly false positives and I've fixed the two real but
> > trivial issues already. Things should be fine.
>
> Sashiko review of v3:
>
>         https://sashiko.dev/#/patchset/20260421-swap-table-p4-v3-0-2f2375=
9a76bc@tencent.com
>
> appears to be complete, so perhaps it went back and figured it out.
>
> It claims to have several "critical" and "high" things, so please
> recheck?

Right, thanks for the head up! Just checked again, still, all reports
are false positives.

Some part may worth adding a WARN_ON or some comment (one was also
suggested by Chris), so both humans and AI will be less confused.

For example sashiko is very concerned about round_down of swp_entry_t,
or alignment of folio's swap entry, which is already a common pattern
now and completely fine. We did plan to use a wrapper for that later
to make it less confusing, not really a problem.

Maybe better also add a bit more info to the commit message.

> From your replies in this thread, I believe that we'll be seeing a v4
> series?

Sure, I'll send a v4, most changes are for cleanup and minor improvements.

