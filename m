Return-Path: <cgroups+bounces-3369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8115591746E
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 00:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B691287F52
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 22:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32B17F39B;
	Tue, 25 Jun 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntt/ncd9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49117F383
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719356390; cv=none; b=oMg+Cf6gHMXZLC7H1KmcVXEtVOvd5WQc409kpEOBMBKZgnxfvATGAZGuv5q7unKz8OMQCvoABo+VCQw3+MQnLA0ljNCy0iNvwomKU1n23DfDimYtbpTUtkCve3kmjgmRLLzeHQQaQBgV/xDec2WBE2KxArq7FOxvZ7tUZOVznFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719356390; c=relaxed/simple;
	bh=4nufzVyDas6rqXanqk2DFPV+HJQhWvNDqqsfFSssBLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cu4Qisf3u7WilHQK5jC3zSuYsXpBQD5GWQd0314xtWpG1nCxwBci2KrKEfYboeZEg846nt77bDd4K/2r5g9b68/tblBFF9Cp341sISrBbl9WyIOP+s92gZv2dodbAfquzInaOdnRo7nO02hkMFdawRUSjzE4vZjARhkhiVDWqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ntt/ncd9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a724440f597so429760366b.0
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 15:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719356387; x=1719961187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nufzVyDas6rqXanqk2DFPV+HJQhWvNDqqsfFSssBLc=;
        b=Ntt/ncd9KledG0mncvVF1FMqlcDTX8GHg7ohIYXQGxgIYguBZvpQVq90qYC2qPXJs8
         XzXZF5IdAjlEMPAI3EUPyc5pIPShvqcftbNnLP6KglErMYhT6QXPVmyCcutLyHHqKmvh
         YD/TnAji1PnAKBV0TYj3OMK/QKYNWZXHRYlBAbtoYUGw00pgwC/awGZaNgQI9gUgDC2g
         4jWrj/jqKIpF5RnG+OJ21mInZykPrInMPbKcv3mjE2a/T0CfXLCBbgvpyIbDlq6m116N
         yS0mXLajOp+Jp8K9AW5CHLqfC88mLAenRnJn7X1nOJUgyx81C7VmIGOAeX96kkpvmxtg
         3j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719356387; x=1719961187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nufzVyDas6rqXanqk2DFPV+HJQhWvNDqqsfFSssBLc=;
        b=imo8bKd8tU4ZTAo83rq1ZERkgK9wfX+VrNs4nGFT7FeaEKw8gVc43C01SfA+gSvflF
         YWlGZO0MMGHvtVfxG1/A3pzhHfv7lcTKwUCI/iBfUPS5Az1oV8ZbG1go6qc8b68wK+26
         ciEGxsNB5Bpdq2/KQLOStg1ezysd5OK4B7sIJzx/uKz4kOPaNlTmOpsm6HFYYP2vDa/h
         QPPiQa8eUtDPfmwfUAwsx52b+W7NuyekI+T98gNcNW6Xc+ABBpewdh3QfY3VUcjJlG6a
         FxIrvGrBT8bgnjK0xQImMMeMcbzQkMgcGATCNCEmmTgzR+UGJxNdMoZ0okuTkcI4MhNs
         Upeg==
X-Forwarded-Encrypted: i=1; AJvYcCUsSiEzO16zlOSfbosvZQYl0WU+jsc7NzBTIyc1dMD9AjZE5F17k49V8+o15u/LSmBC6z9lz8nFEkfoTY8z8FfvnPEKXgcpSw==
X-Gm-Message-State: AOJu0Yx2d1M3caRdBVAK1YM7zfYopWvAEGMFE6ow0e9Z+aQX4KZdyLCQ
	v+52M5LhDU2G+H2L7wcoqvLNYz7zahc7Wy9tJ+F4cfjtOhQ24W/UF/AtrVu5z7tROknPHfxVTcF
	iwJloIs81iFcbLs/zyNrABBiNYhnqn42TXPGt
X-Google-Smtp-Source: AGHT+IH/dDKhmlHal0QbDpSAnlMkS3U3pY+fmF7rZOA5u540GMB1xG2BZwZsKTdBAW+WPZDRIGqL8k4sWqeHNFO8TvI=
X-Received: by 2002:a17:907:c786:b0:a6f:48b2:aac5 with SMTP id
 a640c23a62f3a-a7245b6dbe0mr547974966b.15.1719356386530; Tue, 25 Jun 2024
 15:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
 <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org> <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
 <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
 <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com>
 <ntpnm3kdpqexncc4hz4xmfliay3tmbasxl6zatmsauo3sruwf3@zcmgz7oq5huy>
 <CAJD7tkYqF0pmnw+PqmzPGh7NLeM2KfCwKLMhkFw3sxBOZ3biAA@mail.gmail.com> <a1e847a6-749b-87e8-221f-f9beb6c2ab59@linux.com>
In-Reply-To: <a1e847a6-749b-87e8-221f-f9beb6c2ab59@linux.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 25 Jun 2024 15:59:09 -0700
Message-ID: <CAJD7tkbq-dyhmgBOC0+=FeJ19D-fRpE_pz44cH7fCvtHgr45uQ@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:35=E2=80=AFPM Christoph Lameter (Ampere) <cl@linu=
x.com> wrote:
>
> On Tue, 25 Jun 2024, Yosry Ahmed wrote:
>
> >> In my reply above, I am not arguing to go back to the older
> >> stats_flush_ongoing situation. Rather I am discussing what should be t=
he
> >> best eventual solution. From the vmstats infra, we can learn that
> >> frequent async flushes along with no sync flush, users are fine with t=
he
> >> 'non-determinism'. Of course cgroup stats are different from vmstats
> >> i.e. are hierarchical but I think we can try out this approach and see
> >> if this works or not.
> >
> > If we do not do sync flushing, then the same problem that happened
> > with stats_flush_ongoing could occur again, right? Userspace could
> > read the stats after an event, and get a snapshot of the system before
> > that event.
> >
> > Perhaps this is fine for vmstats if it has always been like that (I
> > have no idea), or if no users make assumptions about this. But for
> > cgroup stats, we have use cases that rely on this behavior.
>
> vmstat updates are triggered initially as needed by the shepherd task and
> there is no requirement that this is triggered simultaenously. We
> could actually randomize the intervals in vmstat_update() a bit if this
> will help.

The problem is that for cgroup stats, the behavior has been that a
userspace read will trigger a flush (i.e. propagating updates). We
have use cases that depend on this. If we switch to the vmstat model
where updates are triggered independently from user reads, it
constitutes a behavioral change.

