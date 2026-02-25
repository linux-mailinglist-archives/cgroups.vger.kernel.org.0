Return-Path: <cgroups+bounces-14383-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKcHC5Vbn2lRagQAu9opvQ
	(envelope-from <cgroups+bounces-14383-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 21:29:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15519D36C
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 21:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1501301A3A0
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 20:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DEE30C61B;
	Wed, 25 Feb 2026 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVJFmv7+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379A30DD00
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051226; cv=none; b=iuSoTeB4AfRk+IAbQl5iosZyeej9ZHoBlNT82jA2FcMxmX2Hzcv7+JJDx4ZOFGfgH05OZZQ6Qu3lO3IQeG9nCTQmYg257I0Je5kNC5p3m5tvAi+bwlJSextSCK2xvICntGxY/x3E4GnwbyandQeILdSQgjFV2M9WBZFWAmLzAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051226; c=relaxed/simple;
	bh=uQ5ODX6Ec6bUxHv4xNuvgLmwIhwEhBrFm24dfHVZiWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6FunksfXnc8lqcbInz01UMv6IjvCO2bAd+O7s5TL7upIWl3ydTUeUfG6tODor5Icfb7VG488L+TTrtbhhbV/DIHkKjeaNbJhmNg3iuy19zUvikhMAEyXiyHPHp5GNlJxMYiJVTTwadSshj/Um9DX20qDwC47RTYtVINuqhGBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVJFmv7+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d19bfe1190so10831a34.1
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 12:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772051224; x=1772656024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnoCZpEnsiZT/nYZfVWRoHJkjSlEny21hV+TMR2IO+k=;
        b=nVJFmv7+kU5hG6NS+CZUn9TF+MHgSNOB/IFg8QlTD9P6+ZpWfxRf57ra9RD9DArXwk
         tjXyl4WdguH1HHXZcmCW7UEp5hHWbSadPVpbRs/EpDn/bKxJ91Um19Gk7WmG4EgS118w
         jJxqhxE/t246Sc4WbUDBBHdK7+7fNcEs7eXtlWgaqR4eDinqBuRBxqw/cU9u6Vk1osO4
         kDqnwqDY7C8sTb4k9NyXHu+9EhG8wOzi6FBGNaKPtv4KBgFHOb+/kIDCFAELMCAtcVw8
         z4Vi0AKLqI+DKQ3JCuZKrH0YifTuQjBHlIJjE7ksI/ykQaCVwV1puU/DbfKhM0k+ys+0
         lYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772051224; x=1772656024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EnoCZpEnsiZT/nYZfVWRoHJkjSlEny21hV+TMR2IO+k=;
        b=pki5kYYkPrwMgx7ieefUf9PjxAcpCcLP7Wrj5YAQs+W0Y935FC1LkMZeaEsxcGArnV
         fE71aAyGEU2I6YeJVA8V1c2m4eupWg3xw5XKRlgSKLcvYgIlMR6yH/BsjlEReNVpEgnY
         GZ3/ylCMLFzHr2F4msq3iYMzLQDVt43z504f1B9z2lbWUFlL1jc4kjqyKeEnaLTcJsnM
         AfJR0ZdPyLVXbpt8EYp/nRLhGxt8amHnkYq1uWi+xpQgk6shwXwGDnWXO023F2Kt+VPN
         f8Di6yeED9nASyX+csGIGRpZTYrDfn19nmKir6s1y/VK3GOMLAjKqBzDsA0XUFEYXUwa
         Xq9w==
X-Forwarded-Encrypted: i=1; AJvYcCWFXs1WOvyv0YpMGoR9ySTDMDRD2r3PfdGdRUP8culo+R1UJRyaHMFctSWmHbaMnSFGlJ0K+m8C@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/tfqwDLrellm5n2iCo96VVHC/r2n+tXj3se6Woen79ZVtTJDJ
	/QTg7pnzAVQ0uI/LLra2+uPlkGLPkQn0rmHUMplzhBI/nP3Zc8qiyp4B
X-Gm-Gg: ATEYQzxlpUlLzUiDg64cgrkiVOQU82oBdexEomvmMLnV2yk08XQ6rhdplOwIeltCAXs
	/Hy8Gzf/UDGQzWaAnan3PVQ+5dmZyi3ov7WN7vCHL4eoK8bqN79SgIIDTDlY+xm+dahgleZfcka
	0/vlT9I6l5yKXy+wRhj5dX9bx3a+c5iutvYZspQgF0c0Edbu54iYC6zxIvV8e7KVlrPjpYFVL4K
	yIrqIob7bx2fnquqlAMnO+6RrpASDIf7c03f9nqPMDHGJYy3qB7BvkFYfuvhqie/UIx2jYAkKsL
	v2lL91nkuX37cYGdPBRsS9q6awU9xAJpV8f7Ld2s7gY9sSPD9jhxkk2wWBvaTwFfK43xEWtdtLL
	1liiIHW0UQIwWbVtU8zcC0X8gr1uxr8GaQ1Inuy7xK8XrF7mEp6OrlV9/lm98tunuF1tcEJnh3Z
	HN0dNlbPrHlg5y3rl0/dEv
X-Received: by 2002:a05:6830:6c07:b0:7cf:e4a1:8b6b with SMTP id 46e09a7af769-7d52bdf6e7fmr9810731a34.4.1772051224348;
        Wed, 25 Feb 2026 12:27:04 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edf0sm8089a34.2.2026.02.25.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:27:02 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	david@kernel.org,
	fvdl@google.com,
	hannes@cmpxchg.org,
	jgg@nvidia.com,
	jiaqiyan@google.com,
	jthoughton@google.com,
	kalyazin@amazon.com,
	mhocko@kernel.org,
	michael.roth@amd.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	pasha.tatashin@soleen.com,
	pbonzini@redhat.com,
	peterx@redhat.com,
	pratyush@kernel.org,
	rick.p.edgecombe@intel.com,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	seanjc@google.com,
	shakeel.butt@linux.dev,
	shivankg@amd.com,
	vannapurve@google.com,
	yan.y.zhao@intel.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 1/7] mm: hugetlb: Consolidate interpretation of gbl_chg within alloc_hugetlb_folio()
Date: Wed, 25 Feb 2026 12:27:00 -0800
Message-ID: <20260225202701.4104505-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <fa4172f57caf8fd3013d13d96211de6bb8cf6d38.1770854662.git.ackerleytng@google.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14383-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF15519D36C
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 16:37:12 -0800 Ackerley Tng <ackerleytng@google.com> wrote:

> Previously, gbl_chg was passed from alloc_hugetlb_folio() into
> dequeue_hugetlb_folio_vma(), leaking the concept of gbl_chg into
> dequeue_hugetlb_folio_vma().
> 
> This patch consolidates the interpretation of gbl_chg into
> alloc_hugetlb_folio(), also renaming dequeue_hugetlb_folio_vma() to
> dequeue_hugetlb_folio() so dequeue_hugetlb_folio() can just focus on
> dequeuing a folio.
> 
> No functional change intended.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Reviewed-by: James Houghton <jthoughton@google.com>

Makes sense to me, this seems like a reasonable semantic change even
without factoring out hugetlb_alloc_folio. Thank you!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> ---
>  mm/hugetlb.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a1832da0f6236..fd067bd394ee0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1380,7 +1380,7 @@ static unsigned long available_huge_pages(struct hstate *h)
>  
>  static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
>  				struct vm_area_struct *vma,
> -				unsigned long address, long gbl_chg)
> +				unsigned long address)
>  {
>  	struct folio *folio = NULL;
>  	struct mempolicy *mpol;
> @@ -1388,13 +1388,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
>  	nodemask_t *nodemask;
>  	int nid;
>  
> -	/*
> -	 * gbl_chg==1 means the allocation requires a new page that was not
> -	 * reserved before.  Making sure there's at least one free page.
> -	 */
> -	if (gbl_chg && !available_huge_pages(h))
> -		goto err;
> -
>  	gfp_mask = htlb_alloc_mask(h);
>  	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
>  
> @@ -1412,9 +1405,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
>  
>  	mpol_cond_put(mpol);
>  	return folio;
> -
> -err:
> -	return NULL;
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> @@ -2962,12 +2952,16 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  		goto out_uncharge_cgroup_reservation;
>  
>  	spin_lock_irq(&hugetlb_lock);
> +
>  	/*
> -	 * glb_chg is passed to indicate whether or not a page must be taken
> -	 * from the global free pool (global change).  gbl_chg == 0 indicates
> -	 * a reservation exists for the allocation.
> +	 * gbl_chg == 0 indicates a reservation exists for the allocation - so
> +	 * try dequeuing a page. If there are available_huge_pages(), try using
> +	 * them!
>  	 */
> -	folio = dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
> +	folio = NULL;
> +	if (!gbl_chg || available_huge_pages(h))
> +		folio = dequeue_hugetlb_folio_vma(h, vma, addr);
> +
>  	if (!folio) {
>  		spin_unlock_irq(&hugetlb_lock);
>  		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
> -- 
> 2.53.0.310.g728cabbaf7-goog
> 
> 

