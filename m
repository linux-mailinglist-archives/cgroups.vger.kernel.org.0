Return-Path: <cgroups+bounces-5022-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF6D98EB7C
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 10:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8EA1C21730
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798AA13342F;
	Thu,  3 Oct 2024 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SRlcLGdQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825AF83CD2
	for <cgroups@vger.kernel.org>; Thu,  3 Oct 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943745; cv=none; b=JvqU2vY9W0TFkIiyjOYma7G+TZsA+dUwonyD+4GiXLyCXWQ4WMSkpiHsSleFimqEKat5Z0ne23uUCfGx4jg/m5U+hKB3QCWzfVz1tA02ZHdD78z2+Phw1KbcdsCfh+IXkHL7bDwx14DYIR6peC7TXxCR6X+KuLjG/I3TvMhQCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943745; c=relaxed/simple;
	bh=7RaI3Z2NMLjbRLFKmOfkKWN5rk80BvCfCf2jc3OH6N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8aRNEkU56gRhpgWkAmQQeqCQbr1YUwxE4xgCZD5/sWmnUh0tujed9vsY6FrCeYXbdkH9i/oCrbcVOmSBITrNHwnxJRgqtSWl4pskYAGsBnod+O0+fuGb2nZPrzLxdIydSU6/twLDCzSZX/xmML0PphzCmhEkE18j43PIXqiL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SRlcLGdQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a93b2070e0cso72785166b.3
        for <cgroups@vger.kernel.org>; Thu, 03 Oct 2024 01:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727943742; x=1728548542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7D08CirM7xuRp06J+f5mwNiOHAYV3NjLlNX5JV7kTAs=;
        b=SRlcLGdQaqdxAgPzUeCl5tj+B3fGid9n32TdxBhrM/NXQqUnqVO9F14/6PGVPiNpzA
         tq6jXVj94iJZ1miJ0NyKRGCVCprCymY+zZfsEtQh7fbj9megStSeewDQ1TcrImZ+BH6X
         g8ls1uIn5+8OfuH99fhdmy01J6j0w0vxYh/O4gL+Fsau7yE5BkT+5OQTB1vK9e2Mjg4v
         /z4RvuHBJnpc312fbFxV7Uxh7YAxlL2yQxXYzuylLzsIjQFJsBM/1jt7WkcvqJSyrbgd
         g6GzAmssdLzzjSRWnmnBJLBh8zEkn+GupnCQvdi+ZdPu+QUFUcQvAZ6QX4+bUk67RJ5q
         lC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943742; x=1728548542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D08CirM7xuRp06J+f5mwNiOHAYV3NjLlNX5JV7kTAs=;
        b=RkVcPFYyz55CMlv3z2tghuDYwMPBEu1QjVMQTn500ISVzl7Qagvjq4pNI9OknPFrMK
         +PzdjljevzE1g4XFquOKDA0Sca75/4vSFNo5FRGOBxrAHgkqxdvzDtNzl9rWymEOI6Qw
         tqFqfrzV1FerfEPKEzl2AUSMWqXQRohzqakddoUgoU1kJByDur4l501BBo36FaYh345K
         jxh68LA357SI1lbQlvjOxgU3lucKGes+Xzbd6JMphc+dOXpg8rshTPruOqWkbWgdg5OQ
         gD+uzN49tj8dLM+giPbCfqezpFo/vkdenyHGzstMn8/tG6+rw4P0QkpjPzJVypVEzT2z
         sfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDtX05SZHiblo4SGJ1EAJcteT+3UpXNGAiMxP/NKLn1VpAVfgO8Jorm8lMUF5Nz3o5c+9xyPK5@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYdg6/G11Ve98jzMRxVgy2oi2ls194n1nLIKTfu1xeVSs2haY
	Z1m58vCnGZyarv8LAQ35LkP/CGtLVvpahJd3knDkD269wHpsAItFJiZM1wys8zc=
X-Google-Smtp-Source: AGHT+IGvbWw2hnN5NuJ3uDlUc9HhXu3sxWuJuPLHyeX6nGIqm/rg554fSuCmfpmRt5IdhcnSwSKgtg==
X-Received: by 2002:a17:907:31c2:b0:a8d:2ec3:94f4 with SMTP id a640c23a62f3a-a98f8387140mr421655966b.54.1727943741884;
        Thu, 03 Oct 2024 01:22:21 -0700 (PDT)
Received: from localhost (109-81-85-183.rct.o2.cz. [109.81.85.183])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910286b9dsm50995966b.42.2024.10.03.01.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:22:21 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:22:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Message-ID: <Zv5UPLRBDAA17AA4@tiehlicka>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <Zvu-n6NFL8wo4cOA@infradead.org>
 <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
 <Zvz5KfmB8J90TLmO@infradead.org>
 <b43527db-e763-4e95-8b0c-591afc0e059c@gmx.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43527db-e763-4e95-8b0c-591afc0e059c@gmx.com>

On Thu 03-10-24 17:41:23, Qu Wenruo wrote:
[...]
> Just a little curious, would it be better to introduce a flag for
> address_space to indicate whether the folio needs to be charged or not?

I would say that an explicit interface seems better because it is easier
to find (grep) and reason about. If you make this address space property
then it is really hard to find all the callers.

-- 
Michal Hocko
SUSE Labs

