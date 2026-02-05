Return-Path: <cgroups+bounces-13719-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFtXKmnXhGlo5gMAu9opvQ
	(envelope-from <cgroups+bounces-13719-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 18:46:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32227F6218
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 18:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 168A4300DD62
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A72C2FFDCA;
	Thu,  5 Feb 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfI683RQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8B1F63CD
	for <cgroups@vger.kernel.org>; Thu,  5 Feb 2026 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313538; cv=pass; b=eiryUp+p38sf/j9ALETr7uVeoWcfmU7EO1U8joxU3GSfx3l6/rP8v67C/QGKGCWmfSMvXOX/Gf8wofwgTNNXEqhjtrYZZ8ttI0FaplXTdCmdyjHac13Xo3sXxIHm5/s/wSMENgjp07Wfqr8s81s03weBXEHM/Uquwm34wmULPfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313538; c=relaxed/simple;
	bh=Ll/RRzm7ChNHDWz+zCP7rMHBSCcw8naeHGz2tHBdwmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO+y/6ZvEuNlBoGGM89Ca/WN829Z/v2gmsFnqdSm/vRx2gUXr+/dfaerJ/tixasurqvsCZXemeyuy73CawjR4HzLrGaUVXaS3ghssd4QYdveA6JDBsNxFJO8xZlBNulmyxnJhMyECbCelyuLFjxrhKC6hKjnzbOgTSvcjWLuU/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfI683RQ; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so1031143f8f.2
        for <cgroups@vger.kernel.org>; Thu, 05 Feb 2026 09:45:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770313537; cv=none;
        d=google.com; s=arc-20240605;
        b=VM0hENVn1ysqTULMfX2e96K2evQL0+IVUb81eQzgKOtYF7AIe2DTOnFjlCzMvhmR5f
         XiDA3pSCg/hDDfayaNhRjXjd1OMf3A6Ubkz26DRpE35crV/myACao1SqbwRV46l1HsSq
         kjugtDL3uYibGKLns8N9IFoRugg5f2hk2+0qCS+lLbIz7JTs7djzCnTzDLmDRyxnW/Mz
         X8boLZ0zFi/oFXic0iSDNb37m5/ImX+81y+eizOjJsRTO6XIYQMUoGHIdVk/Yuypk3Lu
         TYu1oojw7Ctn0FxALnV2jKLvmiuAzhtMofKnEz2upPO38XVruZyEs3zWrYzTuopxaAV/
         N5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h5TqVGLIrAUE8R5UW4/g4MhBNsgiRgWoXjFHS4F8lZw=;
        fh=QF5Tdcr5lwzDVypaKZ+3AY3jug9DG2UQG7NvwvAZ1FM=;
        b=Pv6Fgrhm1aHV+E3rj7wyX2mP1u6He+Qzk3W9c8sMgx4CufvCPZSgBSBxi+dAutEz1C
         nygkC4XX4zOxSZmf14aQy2dRKK6ePPIPmoh0iZH6vR7EOmxgz1EkGvYfPppgaJj7Alth
         n8EkXgEDVlMf//SYdAml3zwimabGPte9fHQN7Gwveygv1nKkdeVbyrqTpM9zHYztx/1R
         OIR7CBPX5db4zJLqXA3i4X/+5apa9I5TjAiEYEvS7PyuY9hWVAISQrqwnRskX0fPotOS
         XYZW6y08+JW5qtU6wDFEFHzNea98r3xx3sCWsckQNQenQLNmFdG4ekrQyYncklSCVMCB
         FbFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770313537; x=1770918337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5TqVGLIrAUE8R5UW4/g4MhBNsgiRgWoXjFHS4F8lZw=;
        b=kfI683RQegz2jX/5T/XHPnYo57fYrGNpfLT0T+EVXegtxR4AuROc7w/p3J5Gdcb2fl
         6fbV6+PlBYvXh/yTn/gFemHKXk/BBNNbLlnSN+ePeXp6hYgOs5qb9tIyVRB2XkFhRPrv
         hWu30g2YE7sIZSS9gWl6VvXYHvl2HjTiUA15cEHt4ndcm5Ef14qH5R5ovWgAgAsRAkP5
         O1KiJ1y7eaFptOPQLY/3QEdcl4eC/vcXEaR48JkI6ZESuNt0Twpjrz7s/SsMkCKbFow4
         3xbcohC6J+/JxPjLLHC5atWB2sJu5hX5pbWYd3z9p3QdxlhibwN+fVe0fhnKXAKKj5Ko
         mEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313537; x=1770918337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h5TqVGLIrAUE8R5UW4/g4MhBNsgiRgWoXjFHS4F8lZw=;
        b=kH/sg6KbSIMIXmKv6zPWzYTq1LiqM1FUpI+VKuj+/jr0XiP6EQwKmuoMYQCQDx7X9W
         sEHp8vekGLgoo+me028OlqylkAMuJ27xUBiRDpJ6fWWjePZnfa/Ujnk0zhIc0UmajI80
         fGhwtsqxSxDqCwAQllkYM9WQIyMjsne9/9FvJtHHSIpaf9GcbmppVmqQkXerYP+tpZI1
         F+zsCSZ/qcMXlvcxUf920tmGoaCTZ/g36bItx3NLtAcUBp6BmGhfX64VzYON/6zqIczq
         caQMt9P5Tuv9CsPQgCxT5reBV5RsH0NWw9CWCemhCo1AoCjzSfZNgoE0Go/xN08VQTXT
         tzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9IzSNZElIkzR1bghaMDiavaBFeE+ZQRIPdvD+CCMOKUIi7p/tjpuaUQomsRGwDQUEjE1BblqU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ip3NfFl5qR5r4sC1/ZBGdQp0s7qHt9HwOEmtsLOmpzjBaJzO
	UTEu9T8PllHx66H+D6lWfsbTTZ4OXUqZBU52C0UADUe//Cwpux4H/gsyrEYYR3r4h1/VvTb28q7
	ys5nKl54HV5Fjtqghg+PeaQ39YJvrnU8=
X-Gm-Gg: AZuq6aKZ9xpdyviGKJ3pUxw75E5VkELtlDEzahLMWA+xRJs8XPrjm5gtNHz8iyTGzRm
	ENiblnLJQexUzCQT2DIUk2TXrSwXdTnwh8qKm7s+699cobDO47pP8gGmz23O0BIgYegNWaSkyO0
	9f1OHpIgH4s//N4FzE0Bt9eIZDsKXnc1Yp1fW/pLR+bUDlNPZoTlNOk8qd7E4UjPmlOvEOW3rF9
	MujW/z9HeRFbMxlvo5AX3pVjNGpuaqgQESSIia+wr73i7IzdlI04DkUNH6aWnzUOzP6VecDG/JW
	lIIMBN5VhLfgNm2UYCMzLWAgOtzKOPQQWyOtStkX
X-Received: by 2002:a5d:5849:0:b0:432:e00b:8687 with SMTP id
 ffacd0b85a97d-4362934c515mr78377f8f.31.1770313536684; Thu, 05 Feb 2026
 09:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205053013.25134-1-jiayuan.chen@linux.dev> <CAKEwX=PMQ1aYWr36XKG7oup3diBXb5vjV=fGZeTmYcx+ebmMtQ@mail.gmail.com>
In-Reply-To: <CAKEwX=PMQ1aYWr36XKG7oup3diBXb5vjV=fGZeTmYcx+ebmMtQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 5 Feb 2026 09:45:25 -0800
X-Gm-Features: AZwV_QiTVjMDiQYOXusEpf0PR0me_oBC5l27xMwTMrBI23cf9pS9stnj9eBMkRg
Message-ID: <CAKEwX=PBsuO27n_Vw112Ss2ZCTFqGem8f134cGKbHUQVL0aQ9g@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: add per-memcg stat for incompressible pages
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13719-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shopee.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 32227F6218
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 9:31=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Wed, Feb 4, 2026 at 9:31=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >
> > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >
> > The global zswap_stored_incompressible_pages counter was added in commi=
t
> > dca4437a5861 ("mm/zswap: store <PAGE_SIZE compression failed page as-is=
")
> > to track how many pages are stored in raw (uncompressed) form in zswap.
> > However, in containerized environments, knowing which cgroup is
> > contributing incompressible pages is essential for effective resource
> > management.
> >
> > Add a new memcg stat 'zswpraw' to track incompressible pages per cgroup=
.
> > This helps administrators and orchestrators to:
> >
> > 1. Identify workloads that produce incompressible data (e.g., encrypted
> >    data, already-compressed media, random data) and may not benefit fro=
m
> >    zswap.
> >
> > 2. Make informed decisions about workload placement - moving
> >    incompressible workloads to nodes with larger swap backing devices
> >    rather than relying on zswap.
> >
> > 3. Debug zswap efficiency issues at the cgroup level without needing to
> >    correlate global stats with individual cgroups.
> >
> > While the compression ratio can be estimated from existing stats
> > (zswap / zswapped * PAGE_SIZE), this doesn't distinguish between
> > "uniformly poor compression" and "a few completely incompressible pages
> > mixed with highly compressible ones". The zswpraw stat provides direct
> > visibility into the latter case.
>

Actually I forgot - can you also update the Documentation:

Documentation/admin-guide/cgroup-v2.rst

to include a short description of the new counter? Thanks!

