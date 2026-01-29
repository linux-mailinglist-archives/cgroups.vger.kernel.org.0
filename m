Return-Path: <cgroups+bounces-13525-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ErvLY3je2nBJAIAu9opvQ
	(envelope-from <cgroups+bounces-13525-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 23:47:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD598B57E8
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 23:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F67F3001CE8
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 22:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209F36A007;
	Thu, 29 Jan 2026 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HIfXK8sh"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143C242D6C;
	Thu, 29 Jan 2026 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726855; cv=none; b=dzyp1qoghLfybuO8KA3M1qXTgDf78UuYnwDYpOzrSoDFiNgNf/TfWFEeg0eQQQQkZRrpsDymKEMy0O9UxnSvSmvuRDhdCpUTyJuYsQpTlC1KxUsitnRPyWkYDAmIOCEjZDKN9soryM/jJDox9ePdngmdmAh7i68JBFDtx37O930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726855; c=relaxed/simple;
	bh=uiMvG/zz/yhp+0rA+x0cCZnbSTkcXcX5rLvmp4X9/+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOURwI8sWjyKy8GQtEcmw2q6VBaXxONcyERDsyKgFvCujrLpuPbmC0sXhJU/ufgr1gnQybYGGrNpnt+Ja7wmtweLdW55sYKVRtW9opuJFxJTx+oOx1a+ltat/Xg8ougC5Z3FTaTkyibteeZvMJ+NG55RTULu4H4+V+i4Lm8SJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HIfXK8sh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XJEzypFq45x7weCRrdusr5Ltkkh4n0qsHxk+FFI3A9g=; b=HIfXK8shJJsslT86DLJQa7Stv0
	T0OR8qZs2lRtw7vk9xbzZP7EP51zQvATjU63rhXO+sr6R7c8OZDMjXJv+8BWBexnGhzAr97m/mhdM
	g+oQ553WxQY4k5zSVjNBMF/rm0ADtbsgfGi+7eMEo6JBm+qsDNEvzzym6ei48YdOMrnGAivSNVdGH
	CNFoswRDij7cx6R5mJrVQ52qlHB7A6J9bpSSA1kEiZiAGYavMFfavIpAoF77C8IWcbXbYTOU1MC6w
	bZhl2+MNmY6xuZnuGrj+lBEE7eApPXBif+zIKPPFBYnvaw7dtfcWusoF35WqeiD+VrgvHPgbTXZbj
	bs/Avipw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlanE-0000000BJkq-14Xd;
	Thu, 29 Jan 2026 22:47:16 +0000
Date: Thu, 29 Jan 2026 22:47:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Rik van Riel <riel@surriel.com>, Song Liu <songliubraving@fb.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix NR_FILE_PAGES accounting in
 collapse_file()
Message-ID: <aXvjdArhPpUNF8BI@casper.infradead.org>
References: <20260129184054.910897-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129184054.910897-1-shakeel.butt@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13525-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim,linux.dev:email]
X-Rspamd-Queue-Id: BD598B57E8
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:40:54AM -0800, Shakeel Butt wrote:
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")

Are you sure this is the right Fixes?  99cb0dbd47a1 wasn't cgroup
aware:

        if (nr_none) {
                struct zone *zone = page_zone(new_page);

                __mod_node_page_state(zone->zone_pgdat, NR_FILE_PAGES, nr_none);
-               __mod_node_page_state(zone->zone_pgdat, NR_SHMEM, nr_none);
+               if (is_shmem)
+                       __mod_node_page_state(zone->zone_pgdat,
+                                             NR_SHMEM, nr_none);
        }

b8eddff8886b added cgroup support:

        if (is_shmem)
-               __inc_node_page_state(new_page, NR_SHMEM_THPS);
+               __inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
        else {
-               __inc_node_page_state(new_page, NR_FILE_THPS);
+               __inc_lruvec_page_state(new_page, NR_FILE_THPS);
                filemap_nr_thps_inc(mapping);
        }

which would seem like the right Fixes: to me?

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/khugepaged.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1d994b6c58c6..1cf8e154e214 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2200,8 +2200,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	else
>  		lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
>  
> +	lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, HPAGE_PMD_NR);
>  	if (nr_none) {
> -		lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
>  		/* nr_none is always 0 for non-shmem. */
>  		lruvec_stat_mod_folio(new_folio, NR_SHMEM, nr_none);
>  	}
> @@ -2238,6 +2238,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	 */
>  	list_for_each_entry_safe(folio, tmp, &pagelist, lru) {
>  		list_del(&folio->lru);
> +		lruvec_stat_mod_folio(folio, NR_FILE_PAGES,
> +				      -folio_nr_pages(folio));
>  		folio->mapping = NULL;
>  		folio_clear_active(folio);
>  		folio_clear_unevictable(folio);
> -- 
> 2.47.3
> 
> 

