Return-Path: <cgroups+bounces-11299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 696C1C167E9
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 19:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FD41B27580
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41A634AB1C;
	Tue, 28 Oct 2025 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hssVsn3Q"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC302288C0A
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676364; cv=none; b=WLOy2SbOiUdZc8YCZzLgkGqJvdP8eBETrEDSZm+4TxK8YpMj31OWVhKEdDoCmj62GJG782+mp+MMoaJDrQTLWmQBUX15llZ+8DukQAqokbzuHMpflVgzKoiVZ6eFntOj3KeefXmEnuay18i1X4p080vcpAEvci8zcfTXlUWxb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676364; c=relaxed/simple;
	bh=rwcnxNG6I32u+/Nrolp8o34FZIHcZuGuCps+y7MpA84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oTQG/ZYcu+sL7mJrEqZwSxpoe6sfupOycw5n7BJQpzXa4YNOmTrcoQQ9puNTKLRTDsydhoIYusDdlQtZQV1Ir43uZ1LjZbFdRQ0thv5eqxpIOEF+wWRk+TbSXIK/zYdvYcDvprfIRTQFyU210gZrLysHGNklVmS8JbF0CRQ67FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hssVsn3Q; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761676360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nf6l5EBnraIwk2fFm2crn/UFRlvBCZhPypt0K7UxZjY=;
	b=hssVsn3Q/lG0Ha8WD0NuxkPn5nIfYTE9daX6kZTPWtQkfcc3c5liTlrsaeobIK+I5u/Qsi
	5u5PKy2Fn5+Y3sy756yujLmcWPZCVTncPzc64DvnC8OzMF/k3zCALlzXU5oKmoAsWHtJ7d
	ssChMGvkIZRChpOs5U70e0V6baHPiU0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chris Mason <clm@meta.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
  bot+bpf-ci@kernel.org,  Andrew Morton <akpm@linux-foundation.org>,  LKML
 <linux-kernel@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,
  inwardvessel <inwardvessel@gmail.com>,  linux-mm <linux-mm@kvack.org>,
  "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,  bpf
 <bpf@vger.kernel.org>,  Martin KaFai Lau <martin.lau@kernel.org>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Tejun
 Heo <tj@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Eduard
 <eddyz87@gmail.com>,  Yonghong Song <yonghong.song@linux.dev>,  Ihor
 Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH v2 08/23] mm: introduce BPF kfuncs to deal with memcg
 pointers
In-Reply-To: <f5d71202-188d-45ff-a5e8-387d060fca47@meta.com> (Chris Mason's
	message of "Tue, 28 Oct 2025 14:03:18 -0400")
References: <20251027231727.472628-9-roman.gushchin@linux.dev>
	<2c91977fcab04be6305bf4be57e825f7e84005d16667adcdfad0585be506537c@mail.kernel.org>
	<87ldkv57nc.fsf@linux.dev>
	<CAADnVQLkza5_95qc0vGYBLUu-4FN_cZEcVywTs5XemTE9O-ZtQ@mail.gmail.com>
	<f5d71202-188d-45ff-a5e8-387d060fca47@meta.com>
Date: Tue, 28 Oct 2025 11:32:31 -0700
Message-ID: <87y0ouri68.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Chris Mason <clm@meta.com> writes:

> On 10/28/25 1:12 PM, Alexei Starovoitov wrote:
>> On Tue, Oct 28, 2025 at 9:11=E2=80=AFAM Roman Gushchin <roman.gushchin@l=
inux.dev> wrote:
>>>
>>> bot+bpf-ci@kernel.org writes:
>>>
>>>> ```
>>>> commit ec8e2e1769704b4f69261f36e6aaf035d47c5f0f
>>>> Author: Roman Gushchin <roman.gushchin@linux.dev>
>>>> Can this dereference a NULL css pointer?  The function checks css for
>>>> NULL at line 42 with "if (css && css_tryget(css))", which suggests css
>>>> can be NULL.  If a BPF program calls this function with a NULL css,
>>>> wouldn't it crash here before reaching that check?
>>>
>>> Here css passed as an argument to bpf_get_mem_cgroup() can't be NULL,
>>> because the BPF verifier guarantees that it's a valid css pointer.
>>>
>>> However the result of rcu_dereference_raw(cgroup->subsys[ssid]) can be
>>> NULL, this is why the "if (css && css_tryget(css))" check is required
>>> down below.
>>=20
>> Yeah. Not sure how feasible it is to teach AI about KF_RCU semantics.
>
> I pulled it down locally to try and w/semcode it is properly catching thi=
s:
>
> False Positives Eliminated
>
> 1. EH-001 NULL dereference - css parameter dereferenced without check
>
> - Why false positive: BPF verifier ensures pointer parameters are
> non-NULL. All kernel kfuncs follow the same pattern of not checking
> parameters for NULL (css_rstat_updated, css_rstat_flush,
> bpf_put_mem_cgroup, etc.). The KF_RET_NULL flag controls return value,
> not parameter nullability.
>
> My plan is to just have the prompt read Documentation/bpf/kfuncs.rst,
> which Eduard suggested.  I'll make a bpf kfuncs pattern and do that.

Awesome, thank you!

