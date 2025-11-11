Return-Path: <cgroups+bounces-11801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D965C4BB99
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 07:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0191882C86
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 06:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B5329E49;
	Tue, 11 Nov 2025 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="N/h4ahcN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDF329E53
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843549; cv=none; b=XuZJymKJgRit/q4FfawiwPuB+2cTGY3XhMYBnDXbcpX9RzMw+J0r5q0G+0n/qua38mu6d58cefSO1szUMNugz5nk1GA6BTkiOl5l6k+Q7eJWEFLvRxg+P7yXZyTyPTcsydApnnrLeqfPAaC5HIRKnavPz3pSZyfYhklRd1nac/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843549; c=relaxed/simple;
	bh=WkPIBxcEOHQ4ilXDCjPP5RJCUvaILWDuUwT419tOHBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFp4dbCKPhCi5xOnvBFBuCt2pAUq/RK/A1NOOun6jkqFp0lTPSFmnYdkpELPCJb8tHF4DQ55YrJPqBHn52nY35bBnPyRb7F8zBLWmFse2toCVn7sLq/u19KSccEtCjgJHg/Aajd/oJ58v62DazK5FL3lomW1WJKuNozdfxYCm3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=N/h4ahcN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7833765433cso4389490b3a.0
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 22:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762843547; x=1763448347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl+GLucGBzlTLWjtZq9oz0wfi6xtPX0PrTL9GqsnyOc=;
        b=N/h4ahcNfF3R32arEM1F6gK6BKI61NUrq+t2EjyJbu609ImOvcQ00jNeGjjFIt9k7C
         trWk1hM5sFB/bmvIkCMROgjK4tc2zNe6bEmlssdSp8C914tmfItN7q/FDqzyYTllMKnY
         JShRnaWBIhG3yigb/oVcchHiucCzwArWrc/tBqcYEpMWhqiV5HJgIKxaNys+OjDihhFy
         x6JoBY4jR9y1bDIGSMIkCYVlqveQexUdM6B+kVHeJBwjmgjxz6thtrGXDhGhnyTDzCYt
         n586VZ0pA0Y0DdQXWmEH4q8kZ725vFOwLp3Nnajc2sxuGrXlaL+rCIEVryYjlEmlOIX/
         BBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762843547; x=1763448347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cl+GLucGBzlTLWjtZq9oz0wfi6xtPX0PrTL9GqsnyOc=;
        b=r3qiZTFSo1STit6N1x3L0D0FHTvUb++oNWFzzgp5yI0uweJuTG8rYrZbtbDo2InLCC
         BdA1F+BPNhn066s3tXQ9+IHlVvYrw5liNd2/6j1FL3z3Z1J+VBm2q65qo5WfBnpBybm2
         ZfnLZWi/rZdITt7LmrmR8twpoYJRNyjtmCIG+3YrJ3TvPEfBXs2DhFf1tNxCc2rdZcCT
         6U0C99VTktn7+c/9jGynNFM4HYwmdjGCR1RRzIL8I1gsRgSW3BngK4B8T8SW0456MXqy
         4KMs7xnOl/ocBwu9qcNbCGWZMiVakksFHoLify5f2MsQITljZQeQ335dhF35FfzZUf4e
         /GBw==
X-Forwarded-Encrypted: i=1; AJvYcCULMgylPli3bi1ETDZCTC0q6TSZCigkaP3kLD4d/jGgbE6dPjXx2nXeOe1nY3QqaAtyGSgqwBta@vger.kernel.org
X-Gm-Message-State: AOJu0YwDoKMAFetbTs0Hn6E1jlJo4ix1dUvSZE9c53He1lbTtfAaP6Hs
	5KHj2cE/0/lEK3m4B6l7Zfw2d1XbsiczkR9VLJcIllYKs/FpwFmSVWawMwDrB7PqQXzEyVvuxgx
	iaXx3aCg=
X-Gm-Gg: ASbGncvV+9g4SDcv9Qc5Ln9HOdBPBT+EylvtbvLip9Nxpu/2D7HYUK9p8GzEvzuU/4s
	DGhtnJPzoSOM2RCbaiXxOGKFbzp5j6QYG641/bEWXXm0Dja8CgKA8898gt+TYajiafDRqY/02ss
	ShBRqU+/+lDm/IO3mHXyUymtctLoxr+KWdJDxonZIdDX4H6OD2+DRvlyuF0fq/csUcf3+DyFFjO
	OunXOKMgz1oFs7g8L6TM5n6c2DL9Jy4AoWfZwBAa3gne1ORvlgjeA5wtavDfBysHW7jPExiqCTE
	fPbUB7VHqVMUn/vz6tgXBzdeZcsTmBInTnJw8scegNv7yV7BomtbKMXScXfjQkmiWDo/pvh/OEz
	Md9b9mDKt0qQNfQ70P+4fOFCqRHrmAeg/qXZ737wECzIPvlHlfYCKObX9kLGIOFZWAyGcmxvF/I
	cqzO6DFdj5Oigo4g==
X-Google-Smtp-Source: AGHT+IEicHLSYzdwynj4I4nc/MYN4IYvIV6/LmFIMqRyJaOIQeaa5JTA6robs499AmJpzGJRfdsVew==
X-Received: by 2002:a05:6a20:3d86:b0:343:3d3c:4685 with SMTP id adf61e73a8af0-353a1de1402mr13983796637.18.1762843547462;
        Mon, 10 Nov 2025 22:45:47 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953e791sm14370759b3a.7.2025.11.10.22.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 22:45:47 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: chenridong@huaweicloud.com
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	jack@suse.cz,
	joel.granados@kernel.org,
	kyle.meyer@hpe.com,
	lance.yang@linux.dev,
	laoar.shao@gmail.com,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mclapinski@google.com,
	mhocko@kernel.org,
	mkoutny@suse.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	tj@kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for on-demand stats flushing
Date: Tue, 11 Nov 2025 14:44:13 +0800
Message-ID: <20251111064415.75290-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <7d46ef17-684b-4603-be7a-a9428149da05@huaweicloud.com>
References: <7d46ef17-684b-4603-be7a-a9428149da05@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 11, 2025 at 9:00 AM Chen Ridong <chenridong@huaweicloud.com> wrote:
>
>
>
> On 2025/11/10 21:50, Michal Koutný wrote:
>> Hello Leon.

Hi Ridong,

>>
>> On Mon, Nov 10, 2025 at 06:19:48PM +0800, Leon Huang Fu <leon.huangfu@shopee.com> wrote:
>>> Memory cgroup statistics are updated asynchronously with periodic
>>> flushing to reduce overhead. The current implementation uses a flush
>>> threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
>>> determining when to aggregate per-CPU memory cgroup statistics. On
>>> systems with high core counts, this threshold can become very large
>>> (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
>>> statistics when userspace reads memory.stat files.
>>>
>
> We have encountered this problem multiple times when running LTP tests. It can easily occur when
> using a 64K page size.
>
> error:
>         memcg_stat_rss 10 TFAIL: rss is 0, 266240 expected
>

Have you encountered this problem in real world?

>>> This is particularly problematic for monitoring and management tools
>>> that rely on reasonably fresh statistics, as they may observe data
>>> that is thousands of updates out of date.
>>>
>>> Introduce a new write-only file, memory.stat_refresh, that allows
>>> userspace to explicitly trigger an immediate flush of memory statistics.
>>
[...]
>>
>> Next, v1 and v2 haven't been consistent since introduction of v2 (unlike
>> some other controllers that share code or even cftypes between v1 and
>> v2). So I'd avoid introducing a new file to V1 API.
>>
>
> We encountered this problem in v1, I think this is a common problem should be fixed.

Thanks for pointing that out.

Thanks,
Leon

[...]

