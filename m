Return-Path: <cgroups+bounces-3393-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529591A3FD
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 12:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61341C21503
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839813DBB6;
	Thu, 27 Jun 2024 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OqzerScv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84B14884B
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484601; cv=none; b=opvHzm8XIzOEqSnKnOFr+J869aVxVaMxFouiFuPtWWmyw7BQuqbSGi9Wf7HfcPlPwawXayCvLupFD2ic16pfxHTJr8L2zUdfwb0XySHkqJvbA9l+bC+4neeEHGTqXUSKD641bSJnQkJAipfJA9zWLTOUENnZdlEokB4+rzqMDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484601; c=relaxed/simple;
	bh=LRDgcjgm9BQ9KYarvp9Kg/ax0ZJhFQ/9F1mLVnVY7C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLn6kQ7/8Fh8FJm7XqbcALPte/rpoNrTfy9NdbII1HCdVasND1ro1I7DUwKfiMtmQINk4qSN2XH7j8mnIylNyggqpaqrS65z33SU/Zd5MPZt2krc6dmtIiteFj2AfwvuT2/mcbpEMEg2bNIba4VvvrioB5w1IiG7ueq5O+aaWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OqzerScv; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so1048931fa.0
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 03:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719484598; x=1720089398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmmTw3VCwIDGot6aMjbOAraGI3hpxG9i1KkAlI0khG8=;
        b=OqzerScvbocSWXMDTqX7M8Dng2wwwOfD69GIdG9mmGHfozH1ghiegFd6Vhh9mmafAB
         ftXwMQFFSRswfbEAWZpmz8PLvXoyj1x89Avkca6CHzI6K6OFl69abr7V7IbBXwBMkS77
         3Dinh7+Sao+fIHSo47EDd9OvRdqCE93l9/5Emty2HPWkufYE6dMNXP0vnul/hPgHQRVu
         S8EBZlG6n4Bv8A9O7cpLwcprp7ayxuwi38oHmuC1XCsyENQQLRCHQy9tUuOOrjBKRTI6
         Z3nMG3yUk+yMnvXn/Ij4/IZNgS6gmiIxp4hhPqOUYnvm23xUtGmbvmELRaGTFACOi+7N
         6Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484598; x=1720089398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmmTw3VCwIDGot6aMjbOAraGI3hpxG9i1KkAlI0khG8=;
        b=e4C+9nMNrLUn3XI25H2xhxk9LE5dfg7UmceisSTwovd2sS83Z15RCYx9cT/o/A311u
         ubuxHSJxTKynHNX7z01lonRA0NkxOEf2MhIuxotGmp7LXDBFoz+2ErmV9+G3FiaU0UAV
         CSlvRBKJcqeCJmk/0PVVDGDAgefQiu9WBKICu28Rv3OieMSDiGlC2pjbke5hQzfOJEEK
         M3bQb2e6TYn40oiRyRoSPfLfB+sVk0uwX5ekTZBpknMdJfmxVgECyyS8F4drnVkmVGFh
         EqUMZr9esoPhcSVqRCH0d3uCHpbpDyOJzB7l2oBXOitRoSn8yVdTaZZqXHa+RDEoNG2Y
         9ETA==
X-Forwarded-Encrypted: i=1; AJvYcCUMFmswlDqVE81m6fZoxhe1T5ufATnclo39NobiE+HpIWy+BDvPxW5v53xGoRI8x31n1KsGx4StbngGuOyUU0jc4HxXQYAMkQ==
X-Gm-Message-State: AOJu0Yw9whuxfbhcYduCpE3X4wCMml74XoXjg3xzA2LZ2Tq3IGb/5DI9
	7JTQvYJ4586+gnPZ2RvkbCUzNXLezMGlh5yBe44sRGHWLC7PTdZJxgIYtZrWqCAdAx5sGBdCwJI
	YQR+tKrvPLpTO9X826LJtBcPk3Z36xA4ZdXPJ
X-Google-Smtp-Source: AGHT+IHRuI3bm5oLeNY23Y3s5LjnQgEJkd2uPyO/1Xl0pgD6QXuNuygP4qwyIwyLSKtflIcqEWxFFIXImPdDuWrJedk=
X-Received: by 2002:a2e:9213:0:b0:2ec:5843:2fb8 with SMTP id
 38308e7fff4ca-2ec5b31d126mr99844701fa.42.1719484597470; Thu, 27 Jun 2024
 03:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
 <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org> <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
 <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
 <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com>
 <ntpnm3kdpqexncc4hz4xmfliay3tmbasxl6zatmsauo3sruwf3@zcmgz7oq5huy>
 <CAJD7tkYqF0pmnw+PqmzPGh7NLeM2KfCwKLMhkFw3sxBOZ3biAA@mail.gmail.com>
 <a1e847a6-749b-87e8-221f-f9beb6c2ab59@linux.com> <CAJD7tkbq-dyhmgBOC0+=FeJ19D-fRpE_pz44cH7fCvtHgr45uQ@mail.gmail.com>
 <43732a44-1f90-4119-9e52-000b5a6a2f99@kernel.org> <CAJD7tkauPM5trAhgYSC5_S_wvOA9gozPeUot-yhAW0fbF+Msag@mail.gmail.com>
 <cf6eac6b-c75f-4879-a9e5-bb8507879900@kernel.org>
In-Reply-To: <cf6eac6b-c75f-4879-a9e5-bb8507879900@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 27 Jun 2024 03:36:01 -0700
Message-ID: <CAJD7tka+DMQfD2MYWD03cc39cxCAbbEOOfYUi1CH5f6FkVbKMw@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>, Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:21=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
> On 27/06/2024 00.07, Yosry Ahmed wrote:
> > On Wed, Jun 26, 2024 at 2:35=E2=80=AFPM Jesper Dangaard Brouer <hawk@ke=
rnel.org> wrote:
> >>
> >> On 26/06/2024 00.59, Yosry Ahmed wrote:
> >>> On Tue, Jun 25, 2024 at 3:35=E2=80=AFPM Christoph Lameter (Ampere) <c=
l@linux.com> wrote:
> >>>>
> >>>> On Tue, 25 Jun 2024, Yosry Ahmed wrote:
> >>>>
> [...]
> >>
> >> I implemented a variant using completions as Yosry asked for:
> >>
> >> [V3] https://lore.kernel.org/all/171943668946.1638606.1320095353103578=
332.stgit@firesoul/
> >
> > Thanks! I will take a look at this a little bit later. I am wondering
> > if you could verify if that solution fixes the problem with kswapd
> > flushing?
>
> I will deploy V3 on some production metals and report back in that thread=
.
>
> For this patch V2, I already have some results that show it solves the
> kswapd lock contention. Attaching grafana screenshot comparing two
> machines without/with this V2 patch. Green (16m1253) without patch, and
> Yellow line (16m1254) with patched kernel.  These machines have 12 NUMA
> nodes and thus 12 kswapd threads, and CPU time is summed for these thread=
s.

Thanks for the data! Looking forward to whether v3 also fixes the
problem. I think it should, especially with the timeout, but let's see
:)

>
> Zooming in with perf record we can also see the lock contention is gone.
>   - sudo perf record -g -p $(pgrep -d, kswapd) -F 499 sleep 60
>   - sudo perf report --no-children  --call-graph graph,0.01,callee
> --sort symbol
>
>
> On a machine (16m1254) with this V2 patch:
>
>   Samples: 7K of event 'cycles:P', Event count (approx.): 61228473670
>     Overhead  Symbol
>   +    8.28%  [k] mem_cgroup_css_rstat_flush
>   +    6.69%  [k] xfs_perag_get_tag
>   +    6.51%  [k] radix_tree_next_chunk
>   +    5.09%  [k] queued_spin_lock_slowpath
>   +    3.94%  [k] srso_alias_safe_ret
>   +    3.62%  [k] srso_alias_return_thunk
>   +    3.11%  [k] super_cache_count
>   +    2.96%  [k] mem_cgroup_iter
>   +    2.95%  [k] down_read_trylock
>   +    2.48%  [k] shrink_lruvec
>   +    2.12%  [k] isolate_lru_folios
>   +    1.76%  [k] dentry_lru_isolate
>   +    1.74%  [k] radix_tree_gang_lookup_tag
>
>
> On a machine (16m1253) without patch:
>
>   Samples: 65K of event 'cycles:P', Event count (approx.): 492125554022
>     Overhead  SymbolCoverage]
>   +   55.84%  [k] queued_spin_lock_slowpath
>     - 55.80% queued_spin_lock_slowpath
>        + 53.10% __cgroup_rstat_lock
>        + 2.63% evict
>   +    7.06%  [k] mem_cgroup_css_rstat_flush
>   +    2.07%  [k] page_vma_mapped_walk
>   +    1.76%  [k] invalid_folio_referenced_vma
>   +    1.72%  [k] srso_alias_safe_ret
>   +    1.37%  [k] shrink_lruvec
>   +    1.23%  [k] srso_alias_return_thunk
>   +    1.17%  [k] down_read_trylock
>   +    0.98%  [k] perf_adjust_freq_unthr_context
>   +    0.97%  [k] super_cache_count
>
> I think this (clearly) shows that the patch works and eliminates kswapd
> lock contention.
>
> --Jesper

