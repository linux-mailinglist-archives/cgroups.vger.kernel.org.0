Return-Path: <cgroups+bounces-15042-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB/4ABgcxGnlwQQAu9opvQ
	(envelope-from <cgroups+bounces-15042-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:32:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5C329DA4
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5597A30B13D1
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DEE4035B0;
	Wed, 25 Mar 2026 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA5CVrGh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C104402B8F
	for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459412; cv=none; b=WY9Zu0aCR0unLjgiTDuEZbNxOQQB3+wY1K2k1SZJsnscqcqqLvCU3qO+kEUu7kuA8q+8oKcsqj62+hYHlrV0qMCk5EG89xjRcA4iRmqp/MdwuCfr8O3hhlArQwZCYsskrsUp3wku6I6+M7wv4nliSdeqMt77cC2vbCiC5rSeXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459412; c=relaxed/simple;
	bh=viTmep3Z4Zu/FWlG2Lc5vRj9CNEZGaZUQ/o6168TUEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXvwTUlIA0Qt6o9JX25caWOp9IVMu8lJ/O0Yt61g6wK4z0FfGnYUuS416B62th4NBpGal0neouMddRmQayfrWrylE9+Ypt2ooNjiIb2m+094+UqbAQoip2dvTV/EAh6qv0qdYcLQcE2WJRamf0rK/tzwKJbNFdvGAyoTMCqvrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA5CVrGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCFEC19423
	for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774459411;
	bh=viTmep3Z4Zu/FWlG2Lc5vRj9CNEZGaZUQ/o6168TUEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mA5CVrGhDe93OQpR2h7epjyJnIZZc/FBNZ3ySFRVDimsYyr3MbqwRVHNCMzIIoqBF
	 VcDXPnhXIXo0sUk6wb9wmNiPnCCBecwqaq+NCxurzSlWcEk+hSCrLdEP5hcxjXx3+s
	 gKmlapIm5GzDo30ZCqqU0DUWp1sWotLmP3LVYYAgR8yMo+STfTfZA9xQoLLd3HJeQe
	 UF1jFPqenUAuCg9l7zUSNpv9Xrh3PFotCNfkqVZaM1vqXxGI9WHerHWbg8rlQndwGw
	 Ed6vLAA33dzo56TBo/S8kUMahOW9Ok9jQ8YQpeY6RaxPYe9kz4LnE2zA1kvNZHv3Y8
	 7SqKO7xNGyy6g==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6674cba2c50so1974200a12.0
        for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 10:23:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU75frl/qMqAAEYskrvkk5cvjB9EoU2vsua+xfdXLr5nVb3WRTvXsM5JrTRF22+eXErwXnoimCs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0avatjBB8UJ/QhnH+BnSRjA/MJQLKYeFgqmO4wKqyEEz5PRu7
	q6DiDqjirUOj9UXVScf7AU7MJVDdA8Bzfy5FXeAR2HTr+kS3cYYv3QQj//6bCJy6u8n799VqVuG
	7MY5YR+FG+hQzFqurqdN03Y7Zd0n4LI8=
X-Received: by 2002:a17:907:3f8d:b0:b96:e1de:db04 with SMTP id
 a640c23a62f3a-b98864026d5mr506266866b.18.1774459410572; Wed, 25 Mar 2026
 10:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320204241.1613861-1-longman@redhat.com> <20260320204241.1613861-2-longman@redhat.com>
 <acE2MoIZ0pl7U7PX@redhat.com> <CAO9r8zOTYPgqc_7TVWjQ=adn=pH1TLLX2cBNfa1Y-x=TOFJT1Q@mail.gmail.com>
 <f7159388-c13f-408c-8cb5-02da8b474f57@redhat.com>
In-Reply-To: <f7159388-c13f-408c-8cb5-02da8b474f57@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Mar 2026 10:23:18 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNRQQDXcHHmgJEeKW=YUPmjaRy2pdYuuD-UOuZGyo29FQ@mail.gmail.com>
X-Gm-Features: AQROBzBGJJDJNzfPNA6teoPhE-ZDBmh1D34LINWdlYk_6fWkscYzld8oyyC0Ym8
Message-ID: <CAO9r8zNRQQDXcHHmgJEeKW=YUPmjaRy2pdYuuD-UOuZGyo29FQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] memcg: Scale up vmstats flush threshold with int_sqrt(nr_cpus+2)
To: Waiman Long <longman@redhat.com>
Cc: Li Wang <liwang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15042-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5BE5C329DA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 9:47=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 3/23/26 8:15 PM, Yosry Ahmed wrote:
> > On Mon, Mar 23, 2026 at 5:46=E2=80=AFAM Li Wang <liwang@redhat.com> wro=
te:
> >> On Fri, Mar 20, 2026 at 04:42:35PM -0400, Waiman Long wrote:
> >>> The vmstats flush threshold currently increases linearly with the
> >>> number of online CPUs. As the number of CPUs increases over time, it
> >>> will become increasingly difficult to meet the threshold and update t=
he
> >>> vmstats data in a timely manner. These days, systems with hundreds of
> >>> CPUs or even thousands of them are becoming more common.
> >>>
> >>> For example, the test_memcg_sock test of test_memcontrol always fails
> >>> when running on an arm64 system with 128 CPUs. It is because the
> >>> threshold is now 64*128 =3D 8192. With 4k page size, it needs changes=
 in
> >>> 32 MB of memory. It will be even worse with larger page size like 64k=
.
> >>>
> >>> To make the output of memory.stat more correct, it is better to scale
> >>> up the threshold slower than linearly with the number of CPUs. The
> >>> int_sqrt() function is a good compromise as suggested by Li Wang [1].
> >>> An extra 2 is added to make sure that we will double the threshold fo=
r
> >>> a 2-core system. The increase will be slower after that.
> >>>
> >>> With the int_sqrt() scale, we can use the possibly larger
> >>> num_possible_cpus() instead of num_online_cpus() which may change at
> >>> run time.
> >>>
> >>> Although there is supposed to be a periodic and asynchronous flush of
> >>> vmstats every 2 seconds, the actual time lag between succesive runs
> >>> can actually vary quite a bit. In fact, I have seen time lags of up
> >>> to 10s of seconds in some cases. So we couldn't too rely on the hope
> >>> that there will be an asynchronous vmstats flush every 2 seconds. Thi=
s
> >>> may be something we need to look into.
> >>>
> >>> [1] https://lore.kernel.org/lkml/ab0kAE7mJkEL9kWb@redhat.com/
> >>>
> >>> Suggested-by: Li Wang <liwang@redhat.com>
> >>> Signed-off-by: Waiman Long <longman@redhat.com>
> > What's the motivation for this fix? Is it purely to make tests more
> > reliable on systems with larger page sizes?
> >
> > We need some performance tests to make sure we're not flushing too
> > eagerly with the sqrt scale imo. We need to make sure that when we
> > have a lot of cgroups and a lot of flushers we don't end up performing
> > worse.
>
> I will include some performance data in the next version. Do you have
> any suggestion of which readily available tests that I can use for this
> performance testing purpose.

I am not sure what readily available tests can stress this. In the
past, I wrote a synthetic workload that spawns a lot of readers in
memory.stat in userspace as well as reclaimers to trigger flushing
from both the kernel and userspace, with a large number of cgroups. I
don't have that lying around unfortunately.

