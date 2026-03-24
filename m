Return-Path: <cgroups+bounces-15007-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIs+BcLYwWkaXQQAu9opvQ
	(envelope-from <cgroups+bounces-15007-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 01:20:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C821D2FF904
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 01:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A67643025A5C
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 00:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAEF1EEA3C;
	Tue, 24 Mar 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9QkazEj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80A1E1A17
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311367; cv=none; b=IiljUafUq76xc9KQao2pXZryyLxBqOW6YLNmLVrl1TWO6smJUO4gOigwlta1sV0HtlXNeB5I0hBAEkbYKFeBvxCmPSipv6Jp1XkG2s42i8K1d9ieYyHQdSioyDsyzEqm+TF99WyUlPA5NdNcyIPg4f8Q8MZjXOYnWHBxvWJoZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311367; c=relaxed/simple;
	bh=6Gx75jnNvcaM6576W+SZe+dNyLWeLhW4qqMK58nkH+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO2zx5i1TncMyZ0+JbiNKXiwP4VRatPvl7z6bfsIDHp4WgC6h6a92W9IZfq7BC1hc+9HqVzWfAzmvGq7GVJxuY1qkW8P+GjPsmKnSFGCIZcOigHqsOTJF/6sLeKYb5b6ryTMzr2vuNY5DMQOY+mJqSbTnKgTB03smyhcTD8SzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9QkazEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FCDC2BCC7
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 00:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311366;
	bh=6Gx75jnNvcaM6576W+SZe+dNyLWeLhW4qqMK58nkH+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T9QkazEjZeWuVoavRP6fU6/RdT7enTVE2M/85RPtx3UryhM9UvzOHhNvJuBAOwqBR
	 N/x4m8Mv6o5TPMS7ifF9Jc7xFwTmdhAn5HnTRHtgcdD7o8rz0LRadWvIODlhvq95kn
	 +yF5LdIgo1PTABH3dm7O7KH5WqmONuF8abQtXSCAo0DknO7PYJG8xsmve1L3+bc9wK
	 S1M0nJ5YurwyTtHduhjl+I2NJMDoXlmd9gWoQpDgRWyZjy2KusrE1sgAFFeOZR8gFm
	 Pyq5AD1MmYt9LD6OEoCbA+AUCGKpK9Dorzh2vgTJCX24erGBheLzkxhWWxWjICCle+
	 TYiy2nE3vtUhg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b982518b73fso145115366b.1
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 17:16:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnAvGRYdCeGcMekTW2yTStPefiW7oRKykUR8ttVuaBraHrV4fCjPusr2bVWduygwEHNwipouBy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0tPJEYqh6PyB1olp/m6dDXTKcf3CpqK7ypHnWt6pbMIR/C7b
	ATaZ3XQJXWpuVPsGE38M2RGqi8tvSJviyXWshNuSKdv7kkVOIolvM31MFBa6Ip81zcOqCzmMDBk
	MnyIpQHxjFXOUpVoPfqOJH7WV/V+jkI8=
X-Received: by 2002:a17:906:1d09:b0:b97:87e4:7f40 with SMTP id
 a640c23a62f3a-b982f37d43dmr878599966b.27.1774311365588; Mon, 23 Mar 2026
 17:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320204241.1613861-1-longman@redhat.com> <20260320204241.1613861-2-longman@redhat.com>
 <acE2MoIZ0pl7U7PX@redhat.com>
In-Reply-To: <acE2MoIZ0pl7U7PX@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 23 Mar 2026 17:15:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOTYPgqc_7TVWjQ=adn=pH1TLLX2cBNfa1Y-x=TOFJT1Q@mail.gmail.com>
X-Gm-Features: AaiRm52fV4nUPr8f7ewBjl2IN6lomvXA8YiY3qcPBfQuorYLYyMi7pBpBc1tcdg
Message-ID: <CAO9r8zOTYPgqc_7TVWjQ=adn=pH1TLLX2cBNfa1Y-x=TOFJT1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] memcg: Scale up vmstats flush threshold with int_sqrt(nr_cpus+2)
To: Li Wang <liwang@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, James Houghton <jthoughton@google.com>, 
	Sebastian Chlad <sebastianchlad@gmail.com>, Guopeng Zhang <zhangguopeng@kylinos.cn>, 
	Li Wang <liwan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15007-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C821D2FF904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 5:46=E2=80=AFAM Li Wang <liwang@redhat.com> wrote:
>
> On Fri, Mar 20, 2026 at 04:42:35PM -0400, Waiman Long wrote:
> > The vmstats flush threshold currently increases linearly with the
> > number of online CPUs. As the number of CPUs increases over time, it
> > will become increasingly difficult to meet the threshold and update the
> > vmstats data in a timely manner. These days, systems with hundreds of
> > CPUs or even thousands of them are becoming more common.
> >
> > For example, the test_memcg_sock test of test_memcontrol always fails
> > when running on an arm64 system with 128 CPUs. It is because the
> > threshold is now 64*128 =3D 8192. With 4k page size, it needs changes i=
n
> > 32 MB of memory. It will be even worse with larger page size like 64k.
> >
> > To make the output of memory.stat more correct, it is better to scale
> > up the threshold slower than linearly with the number of CPUs. The
> > int_sqrt() function is a good compromise as suggested by Li Wang [1].
> > An extra 2 is added to make sure that we will double the threshold for
> > a 2-core system. The increase will be slower after that.
> >
> > With the int_sqrt() scale, we can use the possibly larger
> > num_possible_cpus() instead of num_online_cpus() which may change at
> > run time.
> >
> > Although there is supposed to be a periodic and asynchronous flush of
> > vmstats every 2 seconds, the actual time lag between succesive runs
> > can actually vary quite a bit. In fact, I have seen time lags of up
> > to 10s of seconds in some cases. So we couldn't too rely on the hope
> > that there will be an asynchronous vmstats flush every 2 seconds. This
> > may be something we need to look into.
> >
> > [1] https://lore.kernel.org/lkml/ab0kAE7mJkEL9kWb@redhat.com/
> >
> > Suggested-by: Li Wang <liwang@redhat.com>
> > Signed-off-by: Waiman Long <longman@redhat.com>

What's the motivation for this fix? Is it purely to make tests more
reliable on systems with larger page sizes?

We need some performance tests to make sure we're not flushing too
eagerly with the sqrt scale imo. We need to make sure that when we
have a lot of cgroups and a lot of flushers we don't end up performing
worse.

