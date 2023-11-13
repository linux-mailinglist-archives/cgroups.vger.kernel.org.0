Return-Path: <cgroups+bounces-375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05DF7EA3FA
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69865280ED5
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BA2376E;
	Mon, 13 Nov 2023 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEF7E
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:48:59 +0000 (UTC)
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA43D1A2
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 11:48:58 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
	id ABD8E48CA2; Mon, 13 Nov 2023 11:48:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id A9504489F9;
	Mon, 13 Nov 2023 11:48:57 -0800 (PST)
Date: Mon, 13 Nov 2023 11:48:57 -0800 (PST)
From: Christoph Lameter <cl@linux.com>
To: Matthew Wilcox <willy@infradead.org>
cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
    cgroups@vger.kernel.org
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was
 Re: folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
In-Reply-To: <ZU4yUoiiJYzml0rS@casper.infradead.org>
Message-ID: <4f48d681-376e-100d-01fa-b22d15e8a534@linux.com>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org> <ZUIHk+PzpOLIKJZN@casper.infradead.org> <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com> <ZUqO2O9BXMo2/fA5@casper.infradead.org> <ZU4yUoiiJYzml0rS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 10 Nov 2023, Matthew Wilcox wrote:

>> Maybe Christoph is playing with min_slab_order or something, so we're
>> getting 8 pages per slab.  That's still only 2496 bytes.  Why are we
>> calling into the large kmalloc path?  What's really going on here?
>
> Christoph?

Sorry I thought I already answered that.

This was a boot with slub_min_order=5 that was inadvertently 
left in from a performance test.


