Return-Path: <cgroups+bounces-3473-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C791E9D5
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 22:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968061C22C4F
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC016DED8;
	Mon,  1 Jul 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1Jf7JxW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3501366;
	Mon,  1 Jul 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867195; cv=none; b=FOf+X2tSKCfHCnSbjSdlTAUoerlQ/MbX/9l/4QPzLzrC7lbkXW6k5ZyFjawuRcI9HugX1Bj6m7iLPVIX7nm6Y9jG7epWDVwWpZU3clCErfeow4vI5/JQ2iO4JSLtsm4VereK4XahkzmKXPY774UMFtqZoeMqYEI0OnG2nkkG9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867195; c=relaxed/simple;
	bh=lt4BGmCk6ny+HI2g5q7Yxp0PUjsbeqXpm0NUg+nKBZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcHsZhn/f3YWN3tDGJ40AxQkCXD1kl+lnD/pITds0mrfjXXVXH2NCDhRVjk6tKdKuz5X/U6wVijvpX4EIw2+gSnTZS5AnakCI1C37s3FlHaWkJnhG4lmYu0doLsMlRCaN3jENlyK23Oo+u4enAC7ZGWStXACCKKMKiNt9/rOr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1Jf7JxW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f480624d10so26625135ad.1;
        Mon, 01 Jul 2024 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719867193; x=1720471993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yeNwGtIraX15nopDSfGzXjtkcYBe4iScie4VwTL6O8=;
        b=l1Jf7JxWZI9/HtyCsBOS0ABOGR7ftm9HeMGm0HTogcoeld5H6SDESKs7u+3RXiyf45
         56PozEKEY3OdwY7oLe6a7v5/rW1jyJFcr/x+GOnctoCEfHGQ6vjzSnj+avWWmVZ8J2NJ
         Ij+IYwCeFUt2pG6ZmgFPRNRaiEUveb2/MMBmi05nZGp59jnIjXjRqIRHrUohvyZ0clmM
         NunEfw3D/9Wc9GG8SdI+L9DG9vxavE1CHulaf/7wGdKg6UF/wLlcDrSgpZHaJv6IEa9/
         2pmEI1ZAJQhNPotg0nCLGMHA2q+xJQ/BKib688yD/iHS9IHID48522IvKgwj2qTasqei
         yKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719867193; x=1720471993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yeNwGtIraX15nopDSfGzXjtkcYBe4iScie4VwTL6O8=;
        b=XxIqthB5/ME1k3v1YSHkTBjFl4pZyEqEry8u3W9rGGFtNz3wTm+Gcsb/YaFCrvlnAH
         FK8SXEaEkoOPoypP1VexhT00ikLr7hYHKyMy+4dEyTrSlACjySzujyDqCuifDgyf6NZ/
         bkSGbSG428gK9z2dHG2bZUNkRhmsl0zXP98qgjE+WqX5pcyHnHhJ2/LlIwqzudsQDgLg
         Y8R6t9UuNIgNZE84KykI1C50LYtTMxmRbX2gzEFGGZbrHEsUD5R5scPsT3jMZXvTSRyJ
         I/t8FZXwOSuYW04p+OrTF4zBwlKFyrdmvmuEXIlwZ08uuoyzNxT/fnvx1WkwUYmtVtSy
         cQEw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9TdVoxxr0eNBTmmIxHZh9YwlKmdpGUXl4UZT5nV/ZDjA3u2minXMCibAoXPjE+RC3GLN3UlLfG4zhAyQM1AqTbBOZN0fBtcDzpbMoCXHeNjjxaacn+g72AYk5gAr35on8g3ziw==
X-Gm-Message-State: AOJu0Yz2B6b0wcySCOlhE+jrOxBH6/UsueTZSA0oFz0JC/OsJv1juU/p
	nZHEv8OzWrQRlz2irWT2mUVitkLslQ09NGmNhJuacbDEEsWQIhVL
X-Google-Smtp-Source: AGHT+IGpCMPWMyhLAcVCFpAn1EtVHO3fNLUgFkW61yMh/OI745sezmMwq1XdzHFuxP4VCsxJZi7x5w==
X-Received: by 2002:a17:902:ccc4:b0:1f7:2050:9a76 with SMTP id d9443c01a7336-1fadbc6d60bmr86750695ad.8.1719867193464;
        Mon, 01 Jul 2024 13:53:13 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1538f71sm69446815ad.133.2024.07.01.13.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:53:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 10:53:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Xavier <xavier_qy@163.com>
Cc: longman@redhat.com, mkoutny@suse.com, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH-cpuset v8 1/2] Union-Find: add a new module in kernel
 library
Message-ID: <ZoMXN3G72xtCLjgp@slm.duckdns.org>
References: <Zn3UaMouBYYIMQr_@slm.duckdns.org>
 <20240628161302.240043-1-xavier_qy@163.com>
 <20240628161302.240043-2-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628161302.240043-2-xavier_qy@163.com>

Hello, Xavier.

On Sat, Jun 29, 2024 at 12:13:01AM +0800, Xavier wrote:
...
> +Initializing Union-Find
> +--------------------
> +
> +When initializing the Union-Find data structure, a single pointer to the
> +Union-Find instance needs to be passed. Initialize the parent pointer to point
> +to itself and set the rank to 0.
> +Example::
> +
> +	struct uf_node *my_node = vzalloc(sizeof(struct uf_node));
> +	uf_nodes_init(my_node);

It'd be better to replace the example with something which follows typical
kernel usage.

> diff --git a/include/linux/union_find.h b/include/linux/union_find.h
> new file mode 100644
> index 0000000000..56571c93a5
> --- /dev/null
> +++ b/include/linux/union_find.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

It'd probably be useful to have a brief overview of what this is about and
point to the documentation here.

> +/* Define a union-find node struct */

I don't think the comment is contributing anything.

> +struct uf_node {
> +	struct uf_node *parent;
> +	unsigned int rank;
> +};
> +
> +/* Allocate nodes and initialize to 0 */

and this comment doesn't match what the code is doing. It's neither
allocating or setting everything to zero. Also, please use function comment
style (w/ /** and @ arg descriptions).

> +static inline void uf_nodes_init(struct uf_node *node)
> +{
> +	node->parent = node;
> +	node->rank = 0;
> +}

We'd also need an initializer for static cases.

> +/* find the root of a node*/
> +struct uf_node *uf_find(struct uf_node *node);
> +
> +/* Merge two intersecting nodes */
> +void uf_union(struct uf_node *node1, struct uf_node *node2);

Please use function comment style comments above the implementatino of each
function.

> +struct uf_node *uf_find(struct uf_node *node)
> +{
> +	struct uf_node *parent;
> +
> +	/*Find the root node and perform path compression at the same time*/

Spaces?

> +	while (node->parent != node) {
> +		parent = node->parent;
> +		node->parent = parent->parent;
> +		node = parent;
> +	}
> +	return node;
> +}
> +
> +/*Function to merge two sets, using union by rank*/

Ditto.

Overall, this looks okay to me and the cgroup conversion does look nice.
However, it'd be really nice if you could find another place where this can
be applied.

Thanks.

-- 
tejun

