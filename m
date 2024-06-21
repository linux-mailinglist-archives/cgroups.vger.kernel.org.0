Return-Path: <cgroups+bounces-3270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE46A912F40
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 23:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35161F220C6
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 21:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301617BB31;
	Fri, 21 Jun 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxD+6qre"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9516D4F5;
	Fri, 21 Jun 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004245; cv=none; b=MTRpWmyfLKCiPqvQI3LRMUDB1vbyyrtSt0N2i0RmbXqlnT19wI4XZK5k2zLK4xdesOmglYsYC0Dcp4cAjEjQGF7SCizA9GMY5uCnQxY0UKhzY2Xk9G5MjcJVIEUPiSkUIXoisq+Ln6lvG6rerCh/f3LXKYwfqeO7b3gYnXtQgZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004245; c=relaxed/simple;
	bh=zUJGSvHvejhgjL0rRL/mZwojIs7MlPl8ZOdYcLKjUuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq8dbWnKbl8dGVajjDKOOt26TmKmDAUlbEpUCTL0faD80Zhj0v+KFAUh1UH4mc320BUwifCTl/08EADv4s8KNwmLVzCR0gWOMKYi9eVbJev8HVATOdjkWpht9bOdWIDf6g67Wwx8tZQj0P8t94CJlvML2bp/I9Z/Wh2LgFZOejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxD+6qre; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c8062f9097so1418136a91.3;
        Fri, 21 Jun 2024 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719004244; x=1719609044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEAIfUzFhPU9cFCVgXbRv9q5vfFG7yQV5RUzcmK3UeQ=;
        b=GxD+6qreD2D9LCQMbqVko2U2vPB3GZ00MC2OMLXLWliFbFPC/FXHRGVnx9rwHSAnw4
         F10QfVmZ5Bd4MfI8YVxI41Fl3R4TThpSLPlFqEsE4N37+NxzQz49wliQHsKfbIfy2a90
         ZU0ISHQEg4Qb57+ZY0+NrzxjiqzqhN1fpBSIGoOXyOapZFW9rOouGUy3tOnC7J+FG567
         NVz5C/MV7oNnhEnVkYNjiq7UG9mIkICdjZ9hnfJ/j7Hx6ESakQDYvwaRb8UoncgAmiXD
         hKZlVC2vaqI4NTZt4LR3Po9eeSzPGWYSxLRgu17GHvAe/7nYtNzwm5UH5lF9uDuPaOeH
         gZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004244; x=1719609044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEAIfUzFhPU9cFCVgXbRv9q5vfFG7yQV5RUzcmK3UeQ=;
        b=n0F11MuUp4AhLZmVAmExSsWEsTXDlkzgPRzA+otyk5fGqPnsZ2cPMebfTBDzmJgXR5
         qXFC72av/unf4H0xakr8i4q3Sroqcqw9cub0tqRxQUALfdZ0xCW7uy2v/flxk3EJ/J8c
         /bET3l7+gRsj/bf61VaP9q3ManzsXln2dkro1CRvbaxoYbr/wsZLqegvWtZCSaQXyql/
         CSXGfcrimKM4GPm7cOxLE4jKAe1cjBhyHW/uoiYYhulnGvUfZd+OGaVfVZ7ToZqDxqIq
         E9uo1ffTA+RTz5yufDYN/ivsiYncLNKwjjbcxQ8UVszI1dsg7fYG4f4PRluw6zvSsnxv
         TP3g==
X-Forwarded-Encrypted: i=1; AJvYcCWJCh33OPUNmQ0Tlcbh1A0gf13BqhXQV1ffQfHzdRuILNsmf17HN5AFWZrYlq+UHWHsaGY2lBbF2yhdqNRptx4NbDia6p3Ba9vSC/0LWEl2AH8+1ieMrj5d7bjQbhEsSPlaziv1yQ==
X-Gm-Message-State: AOJu0YwpWtvutk+LiY6K/NcCJJeQA3xExuKAbaYZsXstK5lfHVcDmU5l
	IE6KjJgkN8dyrCtHjfNT6vNMn48CIOsZVuTBmEIq3JMi3mctpbZC
X-Google-Smtp-Source: AGHT+IEr2nv2Yr3awae4ls33FpFHb91mjs8IWuLVvNO/pjy3AjAgECWYNPtG1iZF3TpTRUNTcwCb3Q==
X-Received: by 2002:a17:90a:c296:b0:2c7:a6d0:a0c4 with SMTP id 98e67ed59e1d1-2c7b5c8fdefmr9098527a91.27.1719004243574;
        Fri, 21 Jun 2024 14:10:43 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e0a4dsm4087560a91.17.2024.06.21.14.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:10:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 21 Jun 2024 11:10:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Xavier <xavier_qy@163.com>
Cc: longman@redhat.com, mkoutny@suse.com, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH-cpuset v5 1/2] Union-Find: add a new module in kernel
 library
Message-ID: <ZnXsUnAi7VnX0tZJ@slm.duckdns.org>
References: <b511173c-53fe-4a93-8030-d99ed1b65bd6@redhat.com>
 <20240621084952.209770-1-xavier_qy@163.com>
 <20240621084952.209770-2-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621084952.209770-2-xavier_qy@163.com>

Hello,

On Fri, Jun 21, 2024 at 04:49:51PM +0800, Xavier wrote:
> +/* Define a union-find node struct */
> +struct uf_node {
> +	struct uf_node *parent;
> +	unsigned int rank;
> +};
> +
> +/* Allocate nodes and initialize to 0 */
> +static inline struct uf_node *uf_nodes_alloc(unsigned int node_num)
> +{
> +	return kzalloc(sizeof(struct uf_node) * node_num, GFP_KERNEL);
> +}

This is a very unusual pattern for kernel data structure. Most data
structures allow the member entry to be embedded in other structs or
allocated in user-defined ways. Do they need to be allocated consecutively?
If so, this might be problematic as e.g. 4096 entries, which doesn't sound
too high, would already require consecutive 64k allocation, which is getting
close to vmalloc territory if not already there.

> +struct uf_node *uf_find(struct uf_node *node)
> +{
> +	struct uf_node *parent;
> +
> +	if (!node->parent) {
> +		node->parent = node;
> +		return node;
> +	}
> +
> +	/*Find the root node and perform path compression at the same time*/
> +	while (node->parent != node) {
> +		parent = node->parent;
> +		node->parent = parent->parent;
> +		node = parent;
> +	}
> +	return node;
> +}
> +
> +/*Function to merge two sets, using union by rank*/
> +void uf_union(struct uf_node *node1, struct uf_node *node2)
> +{
> +	struct uf_node *root1 = uf_find(node1);
> +	struct uf_node *root2 = uf_find(node2);
> +
> +	if (root1 != root2) {
> +		if (root1->rank < root2->rank) {
> +			root1->parent = root2;
> +		} else if (root1->rank > root2->rank) {
> +			root2->parent = root1;
> +		} else {
> +			root2->parent = root1;
> +			root1->rank++;
> +		}
> +	}
> +}

Code doesn't seem to suggest allocation needs to be consecutive tho. This is
a bit too generic to route through the cgroup tree without wider reviews.
When you post the next revision, can you please include Linus Torvalds
<torvalds@linux-foundation.org> and Andrew Morton
<akpm@linux-foundation.org> and point to some other possible usages in
kernel?

Thanks.

-- 
tejun

