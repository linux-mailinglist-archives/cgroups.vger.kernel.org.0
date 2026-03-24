Return-Path: <cgroups+bounces-15008-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIL6I9vZwWmJXQQAu9opvQ
	(envelope-from <cgroups+bounces-15008-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 01:24:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0002B2FFA42
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 01:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61143304DF0D
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 00:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F301FF7C8;
	Tue, 24 Mar 2026 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rsogh3ho"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436C1A3164
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311442; cv=none; b=TDo+l05ue7FLZx1kULlhKwLh0eASHTcvXSA1d4GL3eBunAJYzQHZGqL4FPvileewPImirYZ6DfRQMUF+livR6+Jg5lTc4LNsFWFq1WpsuxYHxeRxlz4ycKsRFlvOaezG5Uz9AkL0DN0TnagpX5Sq4BrlOtCRMzdR0CEYueFdLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311442; c=relaxed/simple;
	bh=mkPMr+Ubw3gE/jNPJ4cFqrp/19KQd/EAePHNoJi1hak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8vFqskJ9hSLRY1C4A+kiz8/Pw8Y6AB83KTZItL6wRPmm2Gw8z+JZsw6KlZe8lFjdEDQa3OPf9YFu/w6O58VjOcsrbPU9XCENuOUnO/t66s5jpU6XzXF/Um5+Jgt1KmqBW6rpZHO6PYM9tSfhjRJLk672WIn+TCx6+k3Uqszi0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rsogh3ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53045C2BCB5
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 00:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311442;
	bh=mkPMr+Ubw3gE/jNPJ4cFqrp/19KQd/EAePHNoJi1hak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rsogh3hoyoYJmf99kdqKt6lBJDTP+1xdPyj5kVS2IlN8iHQ3wzE8MkGQ2vG/+vCIQ
	 jglMKyhVHQJLdfMPDmwTBMOYPrv3+D+zxHavwso9XNlhtALMMJjzVyWn1cyTquak5J
	 eYPMoo4H9FNyOu7lRZ4j9CFL0iSDN1ty/nOFJ4CcUJFJDOyfvelrs4EnK/wpc3lDi3
	 vUn5cGfhk9lLEhPwXRKx6PF/rSZNgL8Nn4GVPiuqcdjrhzR7kqcTLKCBF6Lk5unZeU
	 brDDMtaAqTyg+Z5imL12U3VK6iprVbhLo9pompG9YcNDMsaP1Af8EnYT7q/u04edCt
	 eUEztT/Te8+ag==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b98133bdc4bso571172666b.0
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 17:17:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWV9EMTtxQpvH8bD/gjb0uv1uAuaOkxyl9ji3VVKzCz8r6cFV/Byr1vX8J2sDM6zIJoajtEFFo9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9jwr4gQG2LhMN02GlvZuh3R/2CTcOV/0b/icZ9sJUYbQsUw/K
	ibGHGAKo1XlK1Yv1CXszhfHczS5bfXnQET6YN3vc4DHzHgQ76CMTnkA0oOYp1TpnRYB6rJJVQwh
	o3j3fPEC2GCyMzk9ty2P/7O5oscA117E=
X-Received: by 2002:a17:907:3f28:b0:b98:4e9b:7e49 with SMTP id
 a640c23a62f3a-b984e9b9366mr668007566b.33.1774311441088; Mon, 23 Mar 2026
 17:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320204241.1613861-1-longman@redhat.com> <20260320204241.1613861-3-longman@redhat.com>
 <acE2WDuto9cdp5Lx@redhat.com>
In-Reply-To: <acE2WDuto9cdp5Lx@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 23 Mar 2026 17:17:09 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNqHVCOYcun=WWwF3CROi-nLAsJUSJJtcsrQGUKF-CKQQ@mail.gmail.com>
X-Gm-Features: AaiRm531iQ3S4jGCxOVHcyk6sudkGI-5HpMDYVgYjNPDeV0yeExZpsLA0GLu9_E
Message-ID: <CAO9r8zNqHVCOYcun=WWwF3CROi-nLAsJUSJJtcsrQGUKF-CKQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] memcg: Scale down MEMCG_CHARGE_BATCH with increase
 in PAGE_SIZE
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15008-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 0002B2FFA42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 5:47=E2=80=AFAM Li Wang <liwang@redhat.com> wrote:
>
> On Fri, Mar 20, 2026 at 04:42:36PM -0400, Waiman Long wrote:
> > For a system with 4k page size, each percpu memcg_stock can hide up
> > to 256 kbytes of memory with the current MEMCG_CHARGE_BATCH value of
> > 64. For another system with 64k page size, that becomes 4 Mbytes. This
> > hidden charges will affect the accurary of the memory.current value.
> >
> > This MEMCG_CHARGE_BATCH value also controls how often should the
> > memcg vmstat values need flushing. As a result, the values reported
> > in memory.stat cgroup control files are less indicative of the actual
> > memory consumption of a particular memory cgroup when the page size
> > increases from 4k.
> >
> > This problem can be illustrated by running the test_memcontrol
> > selftest. Running a 4k page size kernel on a 128-core arm64 system,
> > the test_memcg_current_peak test which allocates a 50M anonymous memory
> > passed. With a 64k page size kernel on the same system, however, the
> > same test failed because the "anon" attribute of memory.stat file might
> > report a size of 0 depending on the number of CPUs the system has.
> >
> > To solve this inaccurate memory stats problem, we need to scale down
> > the amount of memory that can be hidden by reducing MEMCG_CHARGE_BATCH
> > when the page size increases. The same user application will likely
> > consume more memory on systems with larger page size and it is also
> > less efficient if we scale down MEMCG_CHARGE_BATCH by too much.  So I
> > believe a good compromise is to scale down MEMCG_CHARGE_BATCH by 2 for
> > 16k page size and by 4 with 64k page size.
> >
> > With that change, the test_memcg_current_peak test passed again with
> > the modified 64k page size kernel.
> >
> > Signed-off-by: Waiman Long <longman@redhat.com>

We need performance testing for this too.

