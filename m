Return-Path: <cgroups+bounces-10725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497EABD9521
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 14:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BD81925214
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE40D313556;
	Tue, 14 Oct 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc8MMyJ/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B83128C9
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444621; cv=none; b=n9y+iQBLp5Rfs7ys5sPysmtF2qFKHY5D4GG51Oqzb2PlcBfRve7JXvh+jPqK9ZDnohBzi0C2Kb+RSin/fPbvsVWgQd68iEygLH02yxz6BGPpvOHO94X1jZP5AuQIrGz7oOnrIurD3r1mA51+1X8MSzFfmrs8KsLsSU8Rm76x6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444621; c=relaxed/simple;
	bh=trw3erKcBrmCOtT2DE5wAFGrqWHQObe9Vw1+YmbQxYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8JjLniBbX2Cbx9CC82oCVwO0Z94Rfp98+MGl9F8cPVDWiir+aTJG6H+f1Sqe+/FsY0YZrtNB13LZHxOSI+wwGd2GMFOMWBXTyHBUg7IpK+2geNeAauFwAkCJsleMJI4qaYdoAbg6cvOMHsO7d/1s/Z2sLph+gOZfHdUcqqYQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc8MMyJ/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so987279466b.3
        for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760444617; x=1761049417; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4zpYT42/pWjG2wOiPoPN8UFfIlZHUseBg40P2GM6ks=;
        b=Jc8MMyJ/UeRfPsHTc2O/vVOKfChumvUkphUUc0Yt29Oc4uNhLrkKroREHOW007AgsF
         LQs8rB55fCRWUTPBk8goujK5NS4RW+tmYd8M9TjHH6J3iSPfVW3WFQuXGjSBfnYdxB97
         SrivieCmlJgJ9YPSDxhUxGqZn+YFRE809SXXk4Azw2i7L9FDnCnFtdOuMLnLMCX9uqV4
         oH/byr3DHo4EAjrCdVmzWFTvART0VChXazqVj3bjWtQzRb3V19NPhY42NcAmOU5MhtTb
         s/Ko0LDMTkhQWPW6lke8YNwYIRCHou14iZ7uq9BPw8OQ+Fc9eriOLY6D4gGnfDRePPSp
         HhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444617; x=1761049417;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4zpYT42/pWjG2wOiPoPN8UFfIlZHUseBg40P2GM6ks=;
        b=XMLAccbVXaVusNswYPn6X9A8qOXdrWlTKmrQeBayQ4p0I9Y8UfsjHPe6skKVsOM6f3
         +DQKRTrWYe0lO21EbzwKB/Oecxzw9NaircV8A+ROR6HnibVwrfyOL8daYWK5JyHg5SOH
         OkHhcpt6r1rOH8eLxcnAld6SEhNuXQRo/HsPhPmLxAQj31sjFJVtvkQ9f6N8+o8/1OWk
         37ekipOibn3COS/un8fYZEQ9EahyZvEiPcQObjV7iF2hOIrjdNeb5C0Bl9Wtef1mu0O1
         nPIJYX+neYTDMh9EgvXF26nfqVjbxhkpJkIGH9fByOmdZSWRnRLUmcWvRzc2TUHgR4DV
         z8ng==
X-Forwarded-Encrypted: i=1; AJvYcCUdSj/T8PKfgaC59sD0QqKaS9Mkoq3LQLYfJ/ZMb4ZX+pMbMprwSOxx6BzrUrMohUwwarq+eRvV@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHWC8XpSH0Bh6GZ0tqqyptZCLz1G0pAqtbUAlAmnPD7ewuCI7
	6nWp3xH3xy9YYhk447ACol6rIJjJewXRRxT7M3jsJ3q+SAnEjK6TFVSTE9en5Q==
X-Gm-Gg: ASbGnctVC56zW3pKnIjrLeFHqcUBuiDppR58LEAXWqcmDp53XMmmckXvY0XvX/DnazJ
	/Lxxp6ULxk98ehg19Ue0ZhqvFuKLvGK2V5CZ8n1JqnHFby941zTl5j9l8tsdk8mb5hOccvD3Akg
	DPggjStM0a0QhilmyWSEGOyRizJPy1hcwCgCW2GgCB5lYKUNNhdkOfbRfR7fzTq1E1AUXc7tWfn
	FEQp6BrEdAfVl4FSrV3Vr/2ELwA3suclCX9Q8GxzTxS2gMdwFJHKHu0nGpdcnTjwxa/+NhpDAta
	umggw5oLGE+7xkKQ9nRmiEPKfZZSJ6y0xMj4QcQj85L8RfyG043w2Orv1q+iGQ8tYTB6PNc+0K0
	X70jnOMLAm3IuOCujhN2wFZ9C1n8Qil4wAUbxoiKnJd6Rwo/es0E=
X-Google-Smtp-Source: AGHT+IHDOAfe4JNqhFSA9gUX7LcGwhfmUpTtqm0hZRNoZ9LOkkInOSpqZhVqzK5eUfW8u4Wf52cxuA==
X-Received: by 2002:a17:906:730a:b0:b0b:20e5:89f6 with SMTP id a640c23a62f3a-b50ac5d07b5mr2495753366b.60.1760444616765;
        Tue, 14 Oct 2025 05:23:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b715ffsm11262090a12.22.2025.10.14.05.23.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Oct 2025 05:23:36 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:23:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 20/20] mm: stop maintaining the per-page mapcount of
 large folios (CONFIG_NO_PAGE_MAPCOUNT)
Message-ID: <20251014122335.dpyk5advbkioojnm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-21-david@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303163014.1128035-21-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Mar 03, 2025 at 05:30:13PM +0100, David Hildenbrand wrote:
[...]
>@@ -1678,6 +1726,22 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
> 		break;
> 	case RMAP_LEVEL_PMD:
> 	case RMAP_LEVEL_PUD:
>+		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
>+			last = atomic_add_negative(-1, &folio->_entire_mapcount);
>+			if (level == RMAP_LEVEL_PMD && last)
>+				nr_pmdmapped = folio_large_nr_pages(folio);
>+			nr = folio_dec_return_large_mapcount(folio, vma);
>+			if (!nr) {
>+				/* Now completely unmapped. */
>+				nr = folio_large_nr_pages(folio);
>+			} else {
>+				partially_mapped = last &&
>+						   nr < folio_large_nr_pages(folio);

Hi, David

Do you think this is better to be?

	partially_mapped = last && nr < nr_pmdmapped;

As commit 349994cf61e6 mentioned, we don't support partially mapped PUD-sized
folio yet.

Not sure what I missed here.

>+				nr = 0;
>+			}
>+			break;
>+		}
>+
> 		folio_dec_large_mapcount(folio, vma);
> 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
> 		if (last) {
>-- 
>2.48.1
>

-- 
Wei Yang
Help you, Help me

