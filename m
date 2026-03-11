Return-Path: <cgroups+bounces-14763-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAKlMziAsWmjCwAAu9opvQ
	(envelope-from <cgroups+bounces-14763-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 15:46:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47355265A45
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 15:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F19300578C
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED653BC68A;
	Wed, 11 Mar 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2Z+FVwB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9F3B0ACA
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240134; cv=pass; b=DQQo1oabsguxO4FAW961YYXIRSXZdGxd61VRgkMVoGZIZaTMWeSwSkn/n9tgpk7DvHXSb3625NSdT9tgcmPogulvjtqJq0WMxUNj18axNfFeEqxSu0ygHeXRMysEcwvqgIlS+8o+mNQBSKLnGVSpgOkQOR9GYPDcG7TA7IICJoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240134; c=relaxed/simple;
	bh=zmCW39OgaWQ4ZD39DKNGmgegYx0GjzWyP+Ro+DKMgUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHI1Ps6rbDvh0zlNupniaJSJTZ1LLilGZvHtnE/EUZyUfSJvkIHdJVEj3cxijvxrmU9zwkhBUE0yCSe0lcZE5S9lvCkWB6b+2SWTPaRAeYKSfo3eiFu0deLM015PrpcFNcW9Pgxa0jCWjjx1klIzrrcjgCMHQtAx1A+PKHMA9LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2Z+FVwB; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-661b08b04deso6013944a12.2
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 07:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773240131; cv=none;
        d=google.com; s=arc-20240605;
        b=KU3UrrXppoZa4U8hQ49IkGmWnzCKR0YfqwOo3lxYeeOlKOxYneBAgvmX9YbJ4PPDUI
         QWlKt8UQyQdPQ+kJqNn6scCLqobkO0Qorb2bmOLcq34ITbMk0bCtsjebZiPQ9oC6rl12
         nzdfMSh3qkWLqaX5PEUIg2hoAblDb26h7Eb4ITWl3OsuVwpzhwiVP8rfHbdsDKghhDA9
         37CUjmBTJssW37tA9ZMpC7tw7/IHwnsLcpA6liRjWNrbkDcR3drFvgpMZw3YjFQjSRgw
         fpeor2ClJ2Dl6kiudZIckY4WqU7OP/tdjPjLXbr5b4vErw+BhUMIE8IsgIregHjxdfpQ
         HXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NM9X3+9GKHeQia9vuzomSF6lCtMH3BdBud0LPuMG490=;
        fh=cQLPf8zahf9UOrwriENpdFHRmV6xQYP0ApnRwvED46g=;
        b=hklZblM3Iksoifc/zCvHxfcLr743sxZH4iZsr4dEsiFYcpiA0Nb1ryWenpdMToDV9y
         PehruLeddvtHvTHZfk6gLBM17dI2ndvMgqCXyASMTNy3B7bUd4lnyceDv7+4AZ1fxBA2
         CPhkHnNH1cJBeO3dRQyGxQ3PU4W5usJrGdHVa2dR5cov2YQ5zhzmDAx6gZOTD1a/dEsX
         47NVh4Eku862yAOvw/rBSyx+wjGxdqhpdx5M/nj9MmP0mvHc7EDrzcGzN8qgZfDq6eBH
         sdL7oGuafI7597n5fpA2Hxcogkq/h9YlDrPUCn8ZoXXyW2cRiDlYmYvcH7HK5KjhA11z
         +iSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773240131; x=1773844931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM9X3+9GKHeQia9vuzomSF6lCtMH3BdBud0LPuMG490=;
        b=H2Z+FVwBHl1rd959A1EMb6m/hvnSUI33/s9AtKFbDQ0ncJyjGIaJtY7UIiW5bd34MZ
         85mEN7s9JJ0jit9b3WDpdauSN0hTQaLihn3A5a1OQqvsnbFDkPd2KyQB2Hn8FFHJG3kO
         B3lCJyZfQkehYSRUFCtH9OK8ca75BRYwnUWzcvHudszfGgdh1fOe354gAFYepaesY2AA
         pBijXRFPMRVhw66tfA+LLzNLGJSeTotaRZsslGnFJuc60ya7yn+O7p/Uj0eCnN5I7IYr
         bpqe0MkODihGwU0fQzCJa53h9hBNvhEc5Mq4ezaWwH9b7cWBDJaXQxupK3S8i7CHg1cR
         i2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773240131; x=1773844931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NM9X3+9GKHeQia9vuzomSF6lCtMH3BdBud0LPuMG490=;
        b=D5/0vhV6TK+aTscjpRF+9hLBdZ51FhC8nls2k80ibea+oYnJ9X0Mw1vH9TY8xEhZ2E
         xN+6DyxcW9fHNicIEtgPDdostCLMWVMyJd6FUwBzTKgmONYt5tQBZmOavm6KPXGfOAno
         D4l5NsolK/M3QGq+AHmVTbyg5c02nYDiUPGY7dPDsuZVmeYEFfzpuPBiQoJDPxeLIEam
         x68FNDHFy3NX13+kkeu9P4WI8VniOMFJuRNiWhuKqZsSl2sX3FkzYRPqqwSeeZeO6Ivi
         CkVDQYAajdPMXd9rIp//kWTgFV0fWNkajfTnz+ozCJHRXU1vMOczF31VVi53kVnWH2mz
         kaHA==
X-Forwarded-Encrypted: i=1; AJvYcCX18x01Lk9vQLXmNTKeAAJJWgu592I2/l6wBhHTB1MNVr0W2APEqEXMsQesU5PV68curw1VIAGu@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXTnvZCA+RXRBJaZzpxXurXpDNEvBPaCMBMGkmMcZwlLLQ/3H
	39FQSnXrsO5lD7Lr9xQp7Hub/GxNH/woxWbZ/oQY0F1wCzpuxVrpNqJ5aA9ADgys1fq1uVDLGGp
	H/aPmh10bBc986aCggjYzt396czXw7rA=
X-Gm-Gg: ATEYQzwjnWD6v+Ofc960fvquLz96LfIQt6GBh/NogwW0eIwDrxntllr9/qajSBMt1yM
	41B8QGZ52DpmZF8Xeu5fbOB056R0l2llsHZ898v47MCPfIa2/0wICUEDxe307i5GMCRLFJgyOYw
	0CT+fdfRuSMVgkt8J1ftRdUeTGwqSTX+bWREahm18HnhiDs0Pqb+BT7BprFA4FLTwvjHk5SIEy8
	gHRhebDUFWmcb+0XMrBfI6xxyaF+/eAmVr6FlUpFSxoE1r5dyv2N2wYh0932JeJqVO/bpBoP2O1
	hPKU97Yd8lEvinfBQuBNVZ7uaxKgZGK5yGAQFw==
X-Received: by 2002:a17:907:3c85:b0:b97:257a:772b with SMTP id
 a640c23a62f3a-b972e5c86f9mr171772866b.43.1773240130307; Wed, 11 Mar 2026
 07:42:10 -0700 (PDT)
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
 <CAGudoHHuG-SCgv+F23eScZTnkXxyYKV9xgCBbFntkEaK90hsEQ@mail.gmail.com>
 <eu7erwjzoflxb7wzm7j3iitrwjoukajixasel2s3isfav4i3rv@ko2c2dtmnj2l> <CAGudoHFBN1seqAb3_=Ja+9jXP3EDjfkGfvGT6eqSBhB5_mrBWg@mail.gmail.com>
In-Reply-To: <CAGudoHFBN1seqAb3_=Ja+9jXP3EDjfkGfvGT6eqSBhB5_mrBWg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 11 Mar 2026 15:41:56 +0100
X-Gm-Features: AaiRm51GzsE7oa_IOTL02ypyeZmx5N3lZwNae5heWNKp1rH0SNs4dwEhloqEOGU
Message-ID: <CAGudoHFYCY4m0r6RPTFCgFC4xPp_h3yvk6=xaX1MudoLcCi7-Q@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14763-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 47355265A45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

So I booted up a vm with 80 hw threads and the cgroup lock is still
top of the profile for me when rolling with ./threadspawn1_processes
-t 80

While I prefer my patch on the grounds it reduces overhead to begin
with (fewer locking trips), I wont argue against yours. My primary
goal here is to get cgroups out of the way.

or to put it differently, can you either ack my patch or push yours?

On Tue, Feb 10, 2026 at 6:33=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Tue, Feb 10, 2026 at 5:55=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.=
com> wrote:
> >
> > On Tue, Feb 10, 2026 at 12:19:27PM +0100, Mateusz Guzik <mjguzik@gmail.=
com> wrote:
> > > This is going to depend on the scale you test on. I was testing on
> > > south of 32. But I also got a miniscule win from removing css set loc=
k
> > > as the problem for me, instead everything shifted to tasklist.
> >
> > To be on the same page -- that means you have nr_cpus >=3D 32?
> >
>
> south means less
>
> > > Per my other e-mail tasklist lock retains the terrible 3-times lockin=
g
> > > and it is doing rather expensive work while holding it. It is
> > > plausible it happens to be at the top at that scale, but that's only
> > > an argument for fixing it. Even if you don't see the css thing at the
> > > top at the moment, it will be there once someone(tm) sorts out the
> > > tasklist problem.
> >
> > I did a quick test (with 6.18.8-1.g886f4c4-default), first `perf top`
> > while will-it-scale was running:
>
> I don't know what this hash corresponds to.
>
> >
> >   74.23%  [kernel]                        [k] native_queued_spin_lock_s=
lowpath
> >    6.91%  [kernel]                        [k] intel_idle_irq
> >    0.87%  [kernel]                        [k] update_sd_lb_stats.constp=
rop.0
> >    0.68%  [kernel]                        [k] _raw_spin_lock
> >    0.63%  [kernel]                        [k] clear_page_erms
> >    0.56%  [kernel]                        [k] sched_balance_find_dst_gr=
oup
> >    0.40%  [kernel]                        [k] alloc_vmap_area
> >
> > and then bpftrace for the waiters:
> >   $ bpftrace -e 'kprobe:native_queued_spin_lock_slowpath {@[arg0]=3Dcou=
nt();}
> >                  END {for($kv : @) {printf("%s\t%d\n", ksym($kv.0), (in=
t64)$kv.1);} clear(@); }'\
> >                  >bpftrace.out
> >   $ sort -k2 -r -n bpftrace.out | head | column -t
> >   pidmap_lock         10482583
> >   nft_pcpu_tun_ctx    3693517
> >   css_set_lock        1511164
> >   input_pool          976252
> >   tasklist_lock       798578
> >   nft_pcpu_tun_ctx    481962
> >   0xffff8abc3ffd55b0  95371
> >   0xffff8a6d3ffd65b0  93686
> >   0xffff8a5e218f0840  29501
> >   0xffff8a5e451dca40  29421
> >
> > or measured by cummulative waiting time:
> >   $ bpftrace -e 'kprobe:native_queued_spin_lock_slowpath {@[cpu]=3Darg0=
; @st[cpu]=3Dnsecs;}
> >                  kretprobe:native_queued_spin_lock_slowpath /@[cpu]/ {$=
lat=3Dnsecs-@st[cpu]; @lats[@[cpu]]=3Dsum($lat);}
> >                  END {for($kv : @lats) {printf("%s\t%d\n", ksym($kv.0),=
 (int64)$kv.1);} clear(@lats); clear(@st); clear(@) }'\
> >                  >bpftrace2.out
> >
> >   $ sort -k2 -r -n bpftrace2.out | head -n15 | column -t
> >   pidmap_lock         1931209805
> >   rcu_state           1823286316
> >   rcu_state           1581455156
> >   rcu_state           1328804835
> >   rcu_state           1299517157
> >   rcu_state           1134101627
> >   nft_pcpu_tun_ctx    1027837665
> >   0xffff8abc3ffd55b0  861441978
> >   0xffff8a6d3ffd65b0  850732998
> >   css_set_lock        520009479
> >   input_pool          316598763
> >   tasklist_lock       127161061
> >   0xffff8aac40023200  32380418
> >   0xffff8a5e002ab600  30194951
> >   rcu_state           18334578
> >
>
> If the only thing you applied is the patchset over at
> https://lore.kernel.org/linux-mm/20251206131955.780557-1-mjguzik@gmail.co=
m/
> , then this lines up with my own measurements, where I said the pidmap
> lock remains dominant.
>
> That thing gets unclogged with a patch by Christian to move pidmap
> handling out, which can be found here:
> https://lore.kernel.org/all/20260120-work-pidfs-rhashtable-v2-1-d593c4d0f=
576@kernel.org/
>
> Afterwards it is css_set_lock at the top of the profile.
>
> > Hm, it's interesting that is suggestive of why I saw no big change with
> > css_set_lock in my setup.
> >
>
> Regardless, of the above, I noted sorting out this lock does not
> meaningfully improve performance, it merely shifts contention to
> tasklist afterwards.
>
> >
> > Michal

