Return-Path: <cgroups+bounces-13837-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sq8HMPRri2lhUQAAu9opvQ
	(envelope-from <cgroups+bounces-13837-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 18:33:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7EF11DF38
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 18:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F278303A6F5
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13AF31ED80;
	Tue, 10 Feb 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTTQwVEy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E513D638
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744814; cv=pass; b=r7qlBxdr7FmVvZzFbcHfFqWaxjEbFbH6DV/ujw1sBZQko7T+vsEjypFevfcZuM/sbQiX9EvkDOHp3FuuO9lkBp6DKofuwsOBv5/ZGVsnQcpei8yFpDgoDLv4MO7G4l2M78w2u11+6Vvwm3FNPHAmOBFnT7V6guGhetxEfaN4Dtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744814; c=relaxed/simple;
	bh=TUe1uPAuUYEV2GU3naRmEmDWHpWosTqqAyJ85bZBbsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCn8thdKcKrK+3nwXnT1VnfV9MvMLGdFxDnZWaoAF5f1Dm69NDhdZ9JukFip5qzNCfuXscFgvarSdgPRZKEHLJNvIWnm2A6QzVvTDTDgbRVTOgWLGDWrGvXW+4Vt33c3tp9W1DS2Jv2EBv5xO0BFu/64DWwkvfzwc/EMBLZfkTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTTQwVEy; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso123905a12.0
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 09:33:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770744811; cv=none;
        d=google.com; s=arc-20240605;
        b=SASKC68OPrdhtvIKAE4RT8qEjMZVEqUECqwmXCFxpU3ldXR/uVJi9TxuBQC2CLfADY
         Of++s2uH0GMKb04VkAUSp2INPZC6w5HRZAxqcEE7vMTgtXdvEqFrFm/zpIn2MTaQQakp
         emZ2m8+AfDUvJ2tfhsXEW7aQh9bGKKPM7Vh2Ch3pMT8CYtxQffoj2OgjDeW9qBURZlvp
         UXwWcrWhT28JbEyhmqNq2tIkfaMlaw4PrDVLTtHqBaxAHvqGSCu2wubflUIfWnHCXoAB
         g8k7CgnW7q1jesE/V1wXJRxkzHgai+kbr5KyVzpI7/tFIZV+ingsy7yNJPDVwa+Rov8H
         1r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+PuSrRE0wxY2JRmOSRERj1e3BqOU7WVbToZiST+Wo+Q=;
        fh=Dwdn517WZeLe6uL8VakVJHE5gB2O2yz4pMq9HXgN9dU=;
        b=Qe+unYBypDl0OZRx1Sr3URAsIEwHSlhvH08TKAJacOnCDJU3A4P3Xffaen/HFchIYy
         L1/FN9QtHcpxEbX1kq3VITCldzJq+Prc8T4m7KcoEiL5I6dMiwCmlE2fTA4hz7QpwegQ
         IL2fHpT4euzWN9Nj81/08JnaR13iw2rpeK/BQyW2frxSoKemuSLaN7NuqCJ8k5Z/I/+h
         MI1lxU5PTONwQiNUZooQOPI5HjA8HvJ55OJ9PLK8Xv4bAnmSkbkiDqagAlvtj3D0Nw3u
         nnFm1w3iMTz6T61KnIs9ONs0MwlT0JOQJ3B6fVdxfvBFCv9hz2w24kSxIX+rc2Ayh1Zt
         bDzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770744811; x=1771349611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PuSrRE0wxY2JRmOSRERj1e3BqOU7WVbToZiST+Wo+Q=;
        b=QTTQwVEyF143txkbHRhDCNp6pwqAONl6I/p7cDDEPS0gWm1uUQpOrfgtj8ySNzXPQ2
         tiAapKniiuMSWGLQotFinTH7OG0EjZjBmPIVEEiUgsZDigoHPQbmc++g8gpmCEzAmte2
         FWe6qR3PeIqJINrPtnuGUfmLWwg+6vlcZSzYjzzilCZo1e4jU4cUZzXogu5ox6uLNeTi
         SQQqU2R96QxFrLn9shYF3w8AHDW8OX3qPZSenF0LhQohcIplwj9/BXgV/jVkjbgB8gxE
         +m9MqjIgOyB31zUCZuLU9IQZd+Qn4KwNvsNsRYfGwITYfPvH1FLwXWAAwWWWo0/2FYlC
         1mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770744811; x=1771349611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PuSrRE0wxY2JRmOSRERj1e3BqOU7WVbToZiST+Wo+Q=;
        b=QKr8ighiEmb67F2F7Z+uIsKZ5dI/wx0r2sgY28Q6lrkMHAeNJtrGPqKg/f7nck0SyL
         3zq4po2q6pXDXFlaBWuItGhs9oj61rcb8qaivY4a4qsoamZaxt2Wlw4MIiwLaiCdz5m7
         2kWRQmsVN/mnJZi3V07SOWuxfIjO5qRdW/pk/1kr/dLfSZRG4pZa4clr+z4knlzOcOGB
         izGwfTgakSlFP5wL+s8kEUdajOaXy1BHmZgirZnztT5tHN1oQugHgKfHJEyXaaWRvNB8
         Ctum6o4Y20182FkBNDETluS2pkrDsgSfvx3frHChFdLFqJq8uKqUB4TrZE3lXKM05NNT
         shMw==
X-Forwarded-Encrypted: i=1; AJvYcCWGU0cf1CXUtg0t4DR26k/6cLCao49L//K48MNoet9JC/z8jCYndFdxuNRYKYvSyF29Ru8zl9Ag@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfevVyOOWv95+AoFHXHkNgewxGHTLQue8m0iJv9CxP7JRN+Ag
	kzFnhzi0cSLNXdTYYf622Pe7crFITugKVr21OTvBmFWW8Zb9rmR2IEBw3opDihEzdrqb0wuuWKi
	S5RTB/hAoPPaAeFAgT3EZd6F6PkNt5lI=
X-Gm-Gg: AZuq6aLEx9unnFO1D1NvJQiTkZeL8OsvHDXmqZdSwzQgvpQRi+cNOF4in4U/zfqynPf
	RXhmUz5tOJKbDrw83n95f8RdswJbJarQGEEuAU+SJ7qrksy04XY5bJGAHe33btGVyGl1PmVPXc7
	nkRlJlM60IGcK7mhxGYJwjyjotMlmPLPIm4VwC2lS8MsIok7ZcQNYkrJ+5KARfSWUPJ5Eje0dHV
	PZm/0HCfUuOfaE3cc9Iy+So8rql2Ta7v04qZj0yFCAckIXnXlCJiRslhVRQfN5tEpAebAgp1h2d
	IvJEV5aEQJYeO35xmC4aJ+fHuogjo3i8YqmwmMo=
X-Received: by 2002:a17:907:709:b0:b87:cf6d:8ea with SMTP id
 a640c23a62f3a-b8f50c606d0mr182405966b.27.1770744811157; Tue, 10 Feb 2026
 09:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122112951.1854124-1-mjguzik@gmail.com> <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
 <uwuworxk3warxfnvr7g3gnrh5g7bnnkq5uhbsnoh42muv7zeax@y7ddpcbhwarw>
 <CAGudoHFaUjm7_Eh6VOOGvfscdekk7v2uNPjfLkZfAkR9aCA1Ew@mail.gmail.com>
 <roisfgpkd7tapp7cfjavmih2e2riwh2nczv4nqk25gik7of4pa@3ohyptw6nvb3>
 <jt6kzvdkp4obq7jszyt4muc5ktjjft2idbz3mzkknlxdch6iit@yeumuxzp6gbn>
 <CAGudoHHuG-SCgv+F23eScZTnkXxyYKV9xgCBbFntkEaK90hsEQ@mail.gmail.com> <eu7erwjzoflxb7wzm7j3iitrwjoukajixasel2s3isfav4i3rv@ko2c2dtmnj2l>
In-Reply-To: <eu7erwjzoflxb7wzm7j3iitrwjoukajixasel2s3isfav4i3rv@ko2c2dtmnj2l>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 10 Feb 2026 18:33:19 +0100
X-Gm-Features: AZwV_QhgeZ9GMmVWqhzdNWRlvFSc3IDlzJZVnlrxRB2sw2LO7dLMP-f3R9_XLrw
Message-ID: <CAGudoHFBN1seqAb3_=Ja+9jXP3EDjfkGfvGT6eqSBhB5_mrBWg@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13837-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A7EF11DF38
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 5:55=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Feb 10, 2026 at 12:19:27PM +0100, Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> > This is going to depend on the scale you test on. I was testing on
> > south of 32. But I also got a miniscule win from removing css set lock
> > as the problem for me, instead everything shifted to tasklist.
>
> To be on the same page -- that means you have nr_cpus >=3D 32?
>

south means less

> > Per my other e-mail tasklist lock retains the terrible 3-times locking
> > and it is doing rather expensive work while holding it. It is
> > plausible it happens to be at the top at that scale, but that's only
> > an argument for fixing it. Even if you don't see the css thing at the
> > top at the moment, it will be there once someone(tm) sorts out the
> > tasklist problem.
>
> I did a quick test (with 6.18.8-1.g886f4c4-default), first `perf top`
> while will-it-scale was running:

I don't know what this hash corresponds to.

>
>   74.23%  [kernel]                        [k] native_queued_spin_lock_slo=
wpath
>    6.91%  [kernel]                        [k] intel_idle_irq
>    0.87%  [kernel]                        [k] update_sd_lb_stats.constpro=
p.0
>    0.68%  [kernel]                        [k] _raw_spin_lock
>    0.63%  [kernel]                        [k] clear_page_erms
>    0.56%  [kernel]                        [k] sched_balance_find_dst_grou=
p
>    0.40%  [kernel]                        [k] alloc_vmap_area
>
> and then bpftrace for the waiters:
>   $ bpftrace -e 'kprobe:native_queued_spin_lock_slowpath {@[arg0]=3Dcount=
();}
>                  END {for($kv : @) {printf("%s\t%d\n", ksym($kv.0), (int6=
4)$kv.1);} clear(@); }'\
>                  >bpftrace.out
>   $ sort -k2 -r -n bpftrace.out | head | column -t
>   pidmap_lock         10482583
>   nft_pcpu_tun_ctx    3693517
>   css_set_lock        1511164
>   input_pool          976252
>   tasklist_lock       798578
>   nft_pcpu_tun_ctx    481962
>   0xffff8abc3ffd55b0  95371
>   0xffff8a6d3ffd65b0  93686
>   0xffff8a5e218f0840  29501
>   0xffff8a5e451dca40  29421
>
> or measured by cummulative waiting time:
>   $ bpftrace -e 'kprobe:native_queued_spin_lock_slowpath {@[cpu]=3Darg0; =
@st[cpu]=3Dnsecs;}
>                  kretprobe:native_queued_spin_lock_slowpath /@[cpu]/ {$la=
t=3Dnsecs-@st[cpu]; @lats[@[cpu]]=3Dsum($lat);}
>                  END {for($kv : @lats) {printf("%s\t%d\n", ksym($kv.0), (=
int64)$kv.1);} clear(@lats); clear(@st); clear(@) }'\
>                  >bpftrace2.out
>
>   $ sort -k2 -r -n bpftrace2.out | head -n15 | column -t
>   pidmap_lock         1931209805
>   rcu_state           1823286316
>   rcu_state           1581455156
>   rcu_state           1328804835
>   rcu_state           1299517157
>   rcu_state           1134101627
>   nft_pcpu_tun_ctx    1027837665
>   0xffff8abc3ffd55b0  861441978
>   0xffff8a6d3ffd65b0  850732998
>   css_set_lock        520009479
>   input_pool          316598763
>   tasklist_lock       127161061
>   0xffff8aac40023200  32380418
>   0xffff8a5e002ab600  30194951
>   rcu_state           18334578
>

If the only thing you applied is the patchset over at
https://lore.kernel.org/linux-mm/20251206131955.780557-1-mjguzik@gmail.com/
, then this lines up with my own measurements, where I said the pidmap
lock remains dominant.

That thing gets unclogged with a patch by Christian to move pidmap
handling out, which can be found here:
https://lore.kernel.org/all/20260120-work-pidfs-rhashtable-v2-1-d593c4d0f57=
6@kernel.org/

Afterwards it is css_set_lock at the top of the profile.

> Hm, it's interesting that is suggestive of why I saw no big change with
> css_set_lock in my setup.
>

Regardless, of the above, I noted sorting out this lock does not
meaningfully improve performance, it merely shifts contention to
tasklist afterwards.

>
> Michal

