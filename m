Return-Path: <cgroups+bounces-15742-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sACAAbHFAWqSjgEAu9opvQ
	(envelope-from <cgroups+bounces-15742-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:04:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA0850D49C
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D95B3079D14
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769D377031;
	Mon, 11 May 2026 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crVZvZQp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5936E493
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500754; cv=none; b=BJ3zpAHiLP5nfcNGhKllX8q+Z8tVMZ8CNxol4lUCWoJCQPDHUEhrcvZaHVUC4cjqFCPz06AGEbnFoFuq7wuLH+oD7yo5yBzV0q44D5vwoobJbSzfgvciwPl+fS+YIaLHksiNnCesR/OZCs2eBzc6qUyRLwq4voQ6PPsBxbSXZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500754; c=relaxed/simple;
	bh=E/TJvFs4t4lBs160Q7ddNOnGS+1yrt+GmYwsY8ieCxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl3cVSIWOR+ncgKY9EVTrr7c9bJBqKr21N0wmx51aE2n5jbMPg2+JmEM6JO1fc7fxlZ0qGL6BuKT8/KVJUUGlbYwICim5iGMuZrNK+p85TObdTMwVr+TxP4zOdJikCQI1i/4Z0BQ3eIGGwBB8c2FtXFd0D+M7B6tlDFj/dsjzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crVZvZQp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-459bf19e87bso370216f8f.1
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778500751; x=1779105551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btlqUdi0qGhMKZ3fIin3gDvxyyqT63yde/F745AE8nE=;
        b=crVZvZQpDtP2iYrYETO5PJ5Zteho20POdFeIfBtnrH/7TGw21YcyeLQq8AzeyTJGhh
         /nvqZXJ1gcsV06WBca+TVHOIK+yLbtS5TK6T8NBCeWAfRrUQN6hww4WxWQ/kXNZJq05X
         9sqW0FfCqDD/TwHGq6pXTHnYit95O1g+pRuLKbOZbnRWSm1DR9a7cndIn4BrlumGoc1t
         rIW/DMlWreE7P8fcZ6lSpJeiOeFHVEqaseNaraKpYWj7ByqBMtGqe2ucX4NOqUmqFeQb
         VLeeQs+s8pSmZM0/7LjtRcRE5YIEdZV2HqMwnflNxHs6k+wOXj4eShGIsj1J0zQML7nb
         4HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778500751; x=1779105551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btlqUdi0qGhMKZ3fIin3gDvxyyqT63yde/F745AE8nE=;
        b=IihL9YR7LLzGmMtxVFoPmXF6DbKWdl3bxbgcXZiRLbaq85/cNd/v4sAiSh6d3ihQkC
         3AXfP6tEr8xAoJD4nICcAF6Dt/bD7yetlwn5Agy8daOCSETMccSWXA2NI/jzZoTc9x4o
         j6yRnQfI6MPABPecx7XnW/9bzcL2TOQVokURlHhBK28EajMb4yDdwqESxOvqdja61V7n
         z6K9Jc09xQ6QUhpZxcm7UTGNyfyM1gu+xlBnE2B1qnErJqJS3Jrzs+1goZQt2/1PBxIR
         jG8gl8kgrg/R6c7YNYfZg1lx67tyFvJzlGiqmSnUuNnRi++SrGUjgbm5coWPWOyaOBpw
         Ht7g==
X-Forwarded-Encrypted: i=1; AFNElJ/yo5XgQVIZ/BJuB0jt2G6ZgTfIhDuwa/y8HUVDBCbLJGRxxORl3kKOrc1BxDtcLdcdKApwW7Ji@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7i245O4XjLLCYzrWCVcSFszV9pilCq0PtjT2cyGJr0IWNkTDW
	4Q4I7jAsi7E0OucM6+B16ZkqxTDvjm++L5/H2ZhnYLXsiltDBGwqHNuR
X-Gm-Gg: Acq92OF7ArHMbxOagvMXv35nUTOp2gqg9nddcOXI2yQKOthatSWWNxnn5S1xiuD7uyZ
	wQGAWoXN1CFlkLnEUFxkkct3jALucUnjphof1qRFdLSi2b3aKRvFoHhu3K1qbSqBJrZqdxYCmAL
	fL8hvdGJZLa/YkhQBD+Ur6kk361M9gW5mGKMgYAiSrTIssuoMpR4helstuFc0ntseFBqn20mTNB
	7r1sTjnvZxJynTIb+ATQE8Fsv4QJLlwiI9tt7brcGQs6KgSIeoFgUYdxZxFtWl+oNwjzVbWdQ0f
	JI9C0jzM6zhbA0JvP8IMo215F0UfCuRTqpfeoWimnVyF/pOSvv8unI/1fU+/43379JJ+MvE8++S
	oRW9zZ7AEceUUQEjO4jh/oqttsmMAggngXxE33h465D468sAqELqENszLUjL/zi9tglBV9pUUxL
	wfHZ3ROAqX3tIBywJ6PmrUiEKX7XtqaOJ8LpjUHeyXS/mDamYXY+dWQHlFOqTgjLLrlqu1IZ+G2
	r4FbXeyhmhx
X-Received: by 2002:a5d:588e:0:b0:43d:184:8aa2 with SMTP id ffacd0b85a97d-4546140b235mr21067301f8f.16.1778500750944;
        Mon, 11 May 2026 04:59:10 -0700 (PDT)
Received: from fedora ([185.193.234.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm24580060f8f.29.2026.05.11.04.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:59:10 -0700 (PDT)
Date: Mon, 11 May 2026 12:59:08 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, shuah@kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: check malloc return value in
 alloc_anon functions
Message-ID: <agHEjG7_fHMAnQrw@fedora>
References: <20260511021615.1768623-1-lihongfu@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511021615.1768623-1-lihongfu@kylinos.cn>
X-Rspamd-Queue-Id: 6EA0850D49C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15742-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishalmoola@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:16:15AM +0800, Hongfu Li wrote:
> The alloc_anon() function calls malloc() without checking for a NULL
> return. If memory allocation fails, a NULL pointer dereference will
> occur when accessing the buffer.
> 
> Add proper error handling to return -1 when malloc() fails in all
> four alloc_anon variants:
> - alloc_anon()

Just a nit, It looks like the below already have proper error handling.

> - alloc_anon_50M_check()
> - alloc_anon_noexit()
> - alloc_anon_50M_check_swap()
> 
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index b43da9bc20c4..8ef9c99a82eb 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -61,6 +61,11 @@ int alloc_anon(const char *cgroup, void *arg)
>  	char *buf, *ptr;
>  
>  	buf = malloc(size);
> +	if (buf == NULL) {
> +		fprintf(stderr, "malloc() failed\n");
> +		return -1;
> +	}
> +
>  	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
>  		*ptr = 0;

Every malloc() call in this file has this same pattern. Maybe we'd be
better off making it a helper function?

Either way:
Reviewed-by: Vishal Moola <vishal.moola@gmail.com>

