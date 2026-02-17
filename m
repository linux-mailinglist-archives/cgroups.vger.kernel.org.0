Return-Path: <cgroups+bounces-13985-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAkyCOP7lGm8JgIAu9opvQ
	(envelope-from <cgroups+bounces-13985-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 00:38:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D7F151F64
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 00:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 795F03004202
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 23:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA1324B0C;
	Tue, 17 Feb 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVphXrGh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17F31B837
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371408; cv=pass; b=qAGkoVKdJyMl5a9wnCHR1SonAWMsM9B/EoEzqul0WMyYAQd989vIa0x8XzuXQ3rY5nq9OJQFPncM7VCM2Ygooz7Ec7BOpwoQniwciaheWJi1W0reECNBEa8dNr79yELIfCObAQMB582zR5kJJ4Uoa8cRojmRCoQcPOJvmbn8HQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371408; c=relaxed/simple;
	bh=MM5voXXZM97a0VTnbbiWQBfsAu8METGN0ejqfgD0KW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOWPCXFTDD/91WyxD9mUmeO0QxVX3EqdeAcnA5/cebZV1ijCBx0tjUwO3NLACmkwiKcQ3DfDWS5R6O3uAG6H9VSckGVsSZJZevs4ipfX1v9mFGM3yVRNuisIqSXC2EvvdUdNyXBuU3/Vcd5xnhR6WtW1mG0IOAGHsMm/6bXiafo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVphXrGh; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371119eacso44553225e9.2
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 15:36:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771371395; cv=none;
        d=google.com; s=arc-20240605;
        b=awcJmVZ7trlDMmP0WdMhrB9WUFsRNBiVAInmpymcjId6nmQedpzUmFRIfA8pirfNYM
         XrO4kX7lK6wxCqizpnTfadd+ndwk2/2ZJuvvx7i9evJbSr2dEYuwSBRdj76n4wnUA6bY
         pgNydZDQZgRc3PfSIMKew3sTCP9AWeYRy1wh6TWLkRHlXY0YgLoXNBd6quNzHDM9LilC
         NtlYWGtbeNsesKsMDk5MVX/47Tz4upFyKGINyMM/6luX3Axy/A30k1TtpKZyYVMzFtSu
         6xZYWmVHRmRjnNeA/sMEt8K8dBrTER2aeGuwbQRpMdgtYyKyYfhW6nnWL9wGYwtkN54g
         gI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wk1effero1CXwxRd3Bkv9v1OFKIW6OFHxrrQapskabc=;
        fh=w4BmgKeRNS8B+7d5htZOMElz4E1ctO1T5lI7CBPQBd0=;
        b=SECzFTnQzmGDypEBvoVFWY/z3bV3JyIA7GpS1G4E1I5NwpUMgqDCg4o85Jpzk4AGwT
         3v0HPbUdo0JPymfe1+bphe0vmkbAaP+uQgLdcRSNSNqU8BSphxC6UH8MQspyfTYPeIQ1
         CdABURGmsRVmM5VdBP17cSlR7Ec4+jR2rhInqWDGTlAqIKv1Qm5nowKJA9Yk6Xmp9Ulv
         FUsTwQZR9vVO91s4GZZo/92u/951tAS2/fYqREwydMRw0L+6n4tKgStwOCjsPH9McJIU
         WSeLL4o16FhW/uMgan9WoUHOzdHP0qsJBkaZWiXhn8v/LVlABMCHw3MUph92W7+F4BWf
         SrLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771371395; x=1771976195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk1effero1CXwxRd3Bkv9v1OFKIW6OFHxrrQapskabc=;
        b=RVphXrGh1sCb3PEzP3fU2QxZv8MTl8PMPkxAtgoWYQdLSPeO5aZCisKw2unaKVf0yX
         iRbtwmGfIRKvjnLcRqWxslWDB9o4w3cAsfbgHny/qMSyCj2msSOwf0Gqjd4V8AQ+AoEL
         Sxmziyh5G+tcNeUkTJWR5aWcHLeegWaE8z5JHiXuCoVwrhqBaztnbvcaiKX610EkOazM
         nDv03upb9ZYJjttixWg55y117UBN2Z6Mh0H5vCP4K7y+90EP+3EVkkN7qTplyb1zE69F
         eMLCUagGqlP8UKotJmxlTGoS28kxXsxZl4iMl1uFyN8BXOT8NZGGyPz2PIv+DqZwo7Cf
         F/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771371395; x=1771976195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wk1effero1CXwxRd3Bkv9v1OFKIW6OFHxrrQapskabc=;
        b=tVVfW6PzmilMuJGq6++fzg6+TjCIBjJe5ev66GeYXjo8v5cgsUJkswY65b3UDis3LM
         QoQLJmyrzL3/CxQ1rJutdH8VV/1veTgksCst0732CXJiZM+fkUXdnEMxILcKE2Y9emPq
         4oR56i0FnIogdazaIFgsmuPq65jioxO70whzhogHje9ku4qKcmSS4OvbbO4reM0NyCjW
         qatmfjDXVqyszDgAg6xMNnVWJx5qTFI9UMMWOALz3DeA91eC35d2yfD5fu2h03qTpdDt
         CP86AWHGgSjLpkC8QA2WxxLaT8wKE17TS7BoptHXRvGUV8C4uPKCbwSn9daWTZdCDlzO
         KIDA==
X-Forwarded-Encrypted: i=1; AJvYcCXEYu8ugneDfwidTZkYf+IDaiOqm9w9oL/Ef8+MCYQ3SvyKqAA1eqAbcHYtpELqhCyykfXOzHyW@vger.kernel.org
X-Gm-Message-State: AOJu0YyATxEPMLzN5C0pnjkXmkX7YxLO4B2YinwQgj+WQ4EfypJ6eAoy
	7zydxh6yiiqUwU7eGUJr+1GgTuJLDX8uGtcJnZ5ChtIu952ZrXp79/0FWcbOrGjwPUyMQovnewg
	hOz3wQ9wUlCBhtVFSaH0+4J73lamM1Us=
X-Gm-Gg: AZuq6aLhrfEkqvGiK5fFLvN7U27GygyXS3QM4MhGwW9kxNItNpTytPIFTUecRVLQlQi
	Tj/bAxo+K1voWw98oVmQEg24g6Fa7JcpK1yEfhU/XrnFnF4RWsdscgixsD3RItnmGowUd7VO4IV
	MPHxycTuwLOXDlLeoWU4JfxqlppIGbcDZgNovm75FX4oDaKn/d8yki1ZnX0fSGj7nItCgeYEbXC
	glwV16pQLd23iVKMNLAKB9tDcrl0C2FfZfaFViHlxbcVUnzP2TTeafPtHywe6shkwcj+n+ineMm
	r8UdncdMUkabvUIbr5cXAQzWzHYZX4Gdutl+dYngF50RAoQAehCy8vg=
X-Received: by 2002:a05:600c:6217:b0:480:6910:abd1 with SMTP id
 5b1f17b1804b1-48398b5d5c6mr3435595e9.18.1771371394920; Tue, 17 Feb 2026
 15:36:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-2-nphamcs@gmail.com> <20260208222652.328284-1-nphamcs@gmail.com>
 <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com> <CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com>
In-Reply-To: <CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 17 Feb 2026 15:36:23 -0800
X-Gm-Features: AaiRm50S_8HbiTq-rHvY-Vu5YZbVnz6yG-KBkKAQGni1VF15QKHPJ6JJsJaTSsw
Message-ID: <CAKEwX=N+djRJ7QVYbvi2ziiWdPcpS1Z__wH2=mBef4EGcdNorQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, shikemeng@huaweicloud.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, bhe@redhat.com, osalvador@suse.de, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13985-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79D7F151F64
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:11=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Feb 10, 2026 at 10:00=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> > # free -m
> >               total        used        free      shared  buff/cache   a=
vailable
> > Mem:          31582         909       26388           8        4284    =
   29989
> > Swap:         40959          41       40918
> >
> > The swap setup follows the recommendation from Huang
> > (https://lore.kernel.org/linux-mm/87ed474kvx.fsf@yhuang6-desk2.ccr.corp=
.intel.com/).
> >
> > Test (average of 18 test run):
> > vm-scalability/usemem --init-time -O -y -x -n 1 56G
> >
> > 6.19:
> > Throughput: 618.49 MB/s (stdev 31.3)
> > Free latency: 5754780.50us (stdev 69542.7)
> >
> > swap-table-p3 (3.8%, 0.5% better):
> > Throughput: 642.02 MB/s (stdev 25.1)
> > Free latency: 5728544.16us (stdev 48592.51)
> >
> > vswap (3.2%, 244% worse):
> > Throughput: 598.67 MB/s (stdev 25.1)
> > Free latency: 13987175.66us (stdev 125148.57)
> >
> > That's a huge regression with freeing. I have a vm-scatiliby test
> > matrix, not every setup has such significant >200% regression, but on
> > average the freeing time is about at least 15 - 50% slower (for
> > example /data/vm-scalability/usemem --init-time -O -y -x -n 32 1536M
> > the regression is about 2583221.62us vs 2153735.59us). Throughput is
> > all lower too.

Hi Kairui - a quick update.

Took me awhile to get a host that matches your memory spec:

free -m
               total        used        free      shared  buff/cache   avai=
lable
Mem:           31609        5778        7634          20       18664       =
25831
Swap:          65535           1       65534

I think I managed to reproduce your observations (average over 5 runs):

Baseline (6.19)

real: mean: 191.19s, stdev: 4.53s
user: mean: 46.98s, stdev: 0.15s
sys: mean: 127.97s, stdev: 3.95s
average throughput: 382057 KB/s
average free time: 8179978 usecs

Vswap:

real: mean: 199.85s, stdev: 6.09s
user: mean: 46.51s, stdev: 0.25s
sys: mean: 137.24s, stdev: 6.46s
average throughput: 367437 KB/s
average free time: 9887107.6 usecs

(command is time ./usemem --init-time -w -O -s 10 -n 1 56g)

I think I figured out where the bulk of the regression lay - it's in
the PTE zapping path. In a nutshell, we're not batching in the case
where these PTEs are backed by virtual swap entries with zswap
backends (even though there is not a good reason not to batch), and
unnecessarily performing unnecesary xarray lookups to resolve the
backend for some superfluous checks (2 xarray lookups for every PTE,
which is wasted work because as noted earlier, we ended up not
batching anyway).

Just by simply fixing this issue, the gap is much closer

real: mean: 192.24s, stdev: 4.82s
user: mean: 46.42s, stdev: 0.27s
sys: mean: 129.84s, stdev: 4.59s
average throughput: 380670 KB/s
average free time: 8583381.4 usecs

I also discovered a couple more inefficiencies in vswap free path.
Hopefully once we fix those, the gap will be non-existent.

