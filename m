Return-Path: <cgroups+bounces-4254-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9A95207F
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 18:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56D21C220D0
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677701BB69B;
	Wed, 14 Aug 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0OKZ8Jy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FEE3FB3B;
	Wed, 14 Aug 2024 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654364; cv=none; b=XzMn61POENsijO20KgqN2YcFUp0jM3P9GUI06MnY4a0qK6xeCy0OBuJyTCywJX+3Vj/dCz344yE1I2Q/osZ89BCuJceIA9m9N/NZmoEmAwcJvCcxkGqcEmO6J2AeQeMFTSukcXAS/2xcAKu9lq0aL/URn57JgZOrYm9hDRYs7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654364; c=relaxed/simple;
	bh=/6m0qSF7kuGWPsSrbBYZyFDfh5jbCnZ7GTbLGiS5hq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQelCk5Qa/8p/bCNrkEmCuV4rtT1ITT5bocEQe9/iKHpNrm7I+U1Wn8DLhLEUPFdt3aInHzqTEpADLI4SrHuqxosotjD6XKFBX5tOCb9Bc0nhAUZWsIqZE7RXSnx1Q6InPwK5CLUd5mbMDAXOWeL3TollBkdbHHTr4WgVNp+0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0OKZ8Jy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d2b921c48so5272813b3a.1;
        Wed, 14 Aug 2024 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723654362; x=1724259162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pd/aOCuXphBlRcvtyvS54badApxKrCop/fAGiNRmQ/Q=;
        b=C0OKZ8JyDQsp3sT870wL0RaCM1anOvqHdAkjHpdUVKZ5F1PLVNHxJvoceo+6sjk+q8
         olU5SFPeS/mkUnpsMYGKaAhHIROW9bYE4/BANsuI7l+xGTl3La2+mRm3rPUkaXsgkK6Q
         ykGsh7IN2Gy+w3l6ZUTmK+DdZ8RNKCFCmv483co+hTttDfISDTXxlXp9FenHPwbqPRqk
         XVcw1kqga1C3wB+YvYcozkSvnVT7urKU66XqrEs8zTo/bQorwXPtKa6ZSFi+sgGYStBz
         GBLtifKLkM5xoB1dfUPaLjuaw/wdAi1b+DPudyimuSmRKrBKCw1mKHpJUIhdk4ByG52N
         jfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654362; x=1724259162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pd/aOCuXphBlRcvtyvS54badApxKrCop/fAGiNRmQ/Q=;
        b=bTcvOIM35h+oVi6AiEeYL8b7Xss9kaBhNVqC182zintA87OZzb3p7dcv4E90mcr6LZ
         eD4MZp7B76Zf+KmCL5me3G2cnG20ny/Ru/Rgzwmdut3GZ+76Kq2GoxYvFDe9mzKJC25v
         hIGAu6j5cS91tBW0xFYrGLbNHU80+0C/pgBxpKAHO/z+MOkzPjpqppHZ8Tn2kXIt5C8w
         5t5s2yXupVQbytLGPWAcevXDFmcGRtETfQMgABo2obaYcFN19fj5G56A7gMX7ygChL2q
         kDY2l7MD2XNdGBCmG/YMI22v9cEvtGWSCSwSL+U4740ZZLYWaea2mwjkiNMZw/7cf61q
         JLCg==
X-Forwarded-Encrypted: i=1; AJvYcCXGlNSWVKd0PNh7ktl3R920a2XwWxRTPOVlR+LUFFU0l9SxSAGPVgKJuJFrVnJT2Dh5YkoQlEgF/ienTsZtlbBByS2W27wue0szrkPW3zrm89ZVQjEhKtbGyKmYMi0zY2yLIdOKqA==
X-Gm-Message-State: AOJu0YwQjNatwQeHYsST1bpmDKeTTpzg9YzlK64dQPTEEO8LQQR8qN4L
	v8M5QK4Mi5lIIdJhkHf+jOC7t1LgzuphqsnqnrRQnBSCvOAwDUkVUCMgOw==
X-Google-Smtp-Source: AGHT+IEkYeQgi1yZAIOw3POqd+m9hRdXewQLMNVHJCePYNZKLMu/86pfmLKvKRJiTsWCcorQpAXCzg==
X-Received: by 2002:a05:6a21:398d:b0:1c4:a1f4:3490 with SMTP id adf61e73a8af0-1c8eaf54203mr4176453637.39.1723654361793;
        Wed, 14 Aug 2024 09:52:41 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7ca35fsm2013998a91.9.2024.08.14.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:52:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 14 Aug 2024 06:52:39 -1000
From: Tejun Heo <tj@kernel.org>
To: chenridong <chenridong@huawei.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] cgroup: Disallow delegatee to write all
 interfaces outsize of cgroup ns
Message-ID: <Zrzg1xUSyw_GpMHH@slm.duckdns.org>
References: <20240812073746.3070616-1-chenridong@huawei.com>
 <20240812073746.3070616-3-chenridong@huawei.com>
 <ex5gnhcoobbw74se4uchhqj2lsrcjx5bsh6m5lva2xmujv7uae@34vwukkwhkbc>
 <ZrutqDox2rrr7dlA@slm.duckdns.org>
 <e3bc3535-39af-4993-af29-bd4bd688d984@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3bc3535-39af-4993-af29-bd4bd688d984@huawei.com>

Hello,

On Wed, Aug 14, 2024 at 04:09:59PM +0800, chenridong wrote:
...
> Hi，TJ， We plan to use delegation in cgroup-v2, so I am conducting some
> tests.
> As doc mentions 'Because the resource control interface files in a given
> directory control the distribution of the parent's resources, the delegatee
> shouldn't be allowed to write to them.' However I found a root can write
> parent's file(cgroup.subtree_control) to change the resource limits(a
> fraudulent method). I believe this could pose a risk in some scenarios where
> a root enters a new cgroup ns without unmounting original cgroup system, and
> it can break limitations. For instance, running a docker with --privileged,
> could this be a risk?
> 
> So I sent this patch to discuss whether this case should be addressed?

That sounsd like a misconfiguration. cgroup NS doesn't make much sense if
you don't limit the actual visibility. The interface is half broken in that
situation anyway and if you're leaking filesystem visibility into a
supposedly isolated container, relaxed resource limits aren't biggest of
your problems.

While the proposed change isn't necessarily a bad idea, it's a behavior
change and I don't either modifying existing behavior or introducing a new
mount flag is justified here. Maybe just update the documentation indicating
that the ancestral cgroups shouldn't be visible in a delegated ns?

Thanks.

-- 
tejun

