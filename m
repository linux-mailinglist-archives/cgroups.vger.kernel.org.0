Return-Path: <cgroups+bounces-17564-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L64wF6FETWo8xgEAu9opvQ
	(envelope-from <cgroups+bounces-17564-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 20:25:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0571EA06
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 20:25:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B8R9IeOm;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17564-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17564-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5395300FFA6
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 18:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5E43B6D3;
	Tue,  7 Jul 2026 18:25:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C143C7D6
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 18:25:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448731; cv=none; b=aMAyytLnp8sXBYBcRmyKwQ8gVVog0x8YFSUkhZgXueaC/OL5Pwkhv3tx6V9s6NKG4/rIPZdgWqU4HEOoVd/5Q1cPlYDhwfPhPFwdGhLQHUVZaV4OB+e7Z5O/vSTIPyK5aUYSOgTX5SVimuW5jLzphm8gO2ETgFF4Z1O0sYacX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448731; c=relaxed/simple;
	bh=WDatReQ1diJxMnQ27gX5bGDxa/1pmcVJt3crJPRj6lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d40R6d3c8p6rOBJue9alFgXENjGBpJiIKnA6ZkBovwLWBO92CPsIkvpJjHv1qL/eFYPs4jVUYjsrhXOsMRIHeOZ838ME1qYH9gE9Db+FAQr2cyTfujsZZFKbrmWmjIpMGDoXmHsvXSEfL8rtXk/z7/PsZmGNU1vWXrwkpJS5oiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8R9IeOm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78FF1F00AC4
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783448729;
	bh=UodfhMWHJOTmOaDJSgPxCuKgMVhusPF/cnVjRAHGFO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B8R9IeOmQ/w6CN0kw35IGwlxxnZpEu99nbMX4c/Uz0ZcV4rgegRJI/jZiko7++/tb
	 c7yvthhV1zfsHkolcBeQOX7HTX0sx6KH3vp7Q3YMAFi/s1gGzciFZzeli/XT38Q9XE
	 jIUj0Ye1Vn5XWYnys16iy4Z9wVohuuK2k9yXDeBgmwTe3+cqlvBbVGw5OjeRnTJXaA
	 62BCKeNy8ZiHZVWFCkEqfEs0r5Bljrmi6XyIu93HnVEejHreDAPSoHcaQutzY/dk8r
	 cqIupSIZo4R9LvAy9nA4m6/IzjGrfi2efqDUvgDh8BiMKdxtEm00EAfxT4kT2Xs2Xg
	 r6ZyRyoPdR1gA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso5958692a12.1
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2026 11:25:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/aqCxiyvvP4829aXGLz6MBffvSfhMB2WIe415BrvrfgDvKzAhEHKnsTw8y120WjJIG2ZMK4/PQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CSuDvFtTr2tlZ+9HnNMkxhCoGoICthDRCPCuvEdMLLch0TK/
	DbqdoiWYnM3nqY2sJ47Zgspx2RUxl6BtpzUt+SRv0c+BDSZ/sMIvYDwg/FqiyrNMA2LJEglDrwD
	Yid9Qkjd7017MV7rbmHkM7yPvJ9O4Bpc=
X-Received: by 2002:a17:907:ea8:b0:c15:b27d:51e4 with SMTP id
 a640c23a62f3a-c15b27d5823mr202693266b.20.1783448728654; Tue, 07 Jul 2026
 11:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
In-Reply-To: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 7 Jul 2026 11:25:16 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNJh65SZzdW8Cc8_8N5Wr+ORuRtU3kuaAX_DhLaESFYTA@mail.gmail.com>
X-Gm-Features: AVVi8CfOmsujy8Bb6nVmdtBpnu4IHHs228GbFDG2jlrs3NnSjCrtP5K0xKzG314
Message-ID: <CAO9r8zNJh65SZzdW8Cc8_8N5Wr+ORuRtU3kuaAX_DhLaESFYTA@mail.gmail.com>
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, Shuah Khan <shuah@kernel.org>, mhocko@kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17564-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,cmpxchg.org,gmail.com,linux.dev,kernel.org,suse.com,linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zenghui.yu@linux.dev,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9A0571EA06

On Tue, Jul 7, 2026 at 2:38=E2=80=AFAM Zenghui Yu <zenghui.yu@linux.dev> wr=
ote:
>
> Hi,
>
> Running cgroup/test_zswap on my arm64 box failed immediately with:
>
>   [root@localhost cgroup]# ./test_zswap
>   TAP version 13
>   1..8
>   # zswpout does not increase after test program
>   not ok 1 test_zswap_usage
>   [...]
>
> I'm sure that pages are successfully written into zswap by checking the
> count_memcg_events(.., idx=3DZSWPOUT, ..) trace events. But "zswpout_afte=
r"
> in test_zswap_usage() is 0 and results in this failure.
>
> I guess the problem is that (in this particular case) the memcg stats has
> not been flushed when userspace reads it.
>
>  memcg_stat_format()
>    mem_cgroup_flush_stats()
>      __mem_cgroup_flush_stats(.., force=3Dfalse)
>        needs_flush =3D memcg_vmstats_needs_flush();
>
>  static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
>  {
>         return atomic_long_read(&vmstats->stats_updates) >
>                 MEMCG_CHARGE_BATCH * num_online_cpus();
>  }
>
> I can image that memcg_vmstats_needs_flush() will return false because I'=
m
> testing a 16k-page-size kernel on a box with 96 cpus..
>
> As we have a periodic flusher flushed all the stats every 2 seconds, I us=
e
> the following diff to wait the flusher to expose the accurate stats to
> userspace.
>
> diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/tes=
ting/selftests/cgroup/lib/cgroup_util.c
> index 3ce134509041..9596f294da0b 100644
> --- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
> @@ -95,6 +95,8 @@ int cg_read(const char *cgroup, const char *control, ch=
ar *buf, size_t len)
>
>         snprintf(path, sizeof(path), "%s/%s", cgroup, control);
>
> +       sleep(2);
> +
>         ret =3D read_text(path, buf, len);
>         return ret >=3D 0 ? 0 : ret;
>  }
>
> I have no idea how to "fix" it properly. Please have a look!

We were discussing a way for userspace to explicitly trigger a flush
before, which would come in handy for testing. However, we decided not
to expose flushing as a concept to userspace.

Unfortunately I think the only way to "fix" the test is to allocate
more memory, enough to trigger a flush on most interesting setups.
Perhaps we should scale the amount of memory with the number of CPUs
so that we don't have to keep playing whack-a-mole.

