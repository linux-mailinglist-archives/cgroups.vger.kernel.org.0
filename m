Return-Path: <cgroups+bounces-1722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E785D2AF
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890981C21DB1
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8353C684;
	Wed, 21 Feb 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3depReg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90473B793;
	Wed, 21 Feb 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504834; cv=none; b=JunIH0YVdaABl7hOHVDnsjLfiEVGwBhon/QUGHM0pR/6JCXwEPz5a9JvPhjMZZrl560JqHqt1sBL7TmdAyuyXCGhzES28cykLrv0R+Uv5ssJ97wcr2Ud3lQ0MtEk1/jeFMu9XI6EDa6QCRT9h8gSMPska4Cl3Hez/biOOfVmdb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504834; c=relaxed/simple;
	bh=7xitJWaFMoGdC6EmLXwVDyXLfZ/qyA8Ri94E+4oSwBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2joHhXrQFeIH7Pm1u/d0FDUL6kzPNEVymhtcB9IBIrCMDyUS+GiNceogfy2eNeTN2hTzXTCQUS1QTC75/E54l7WmH/eP6BuLBJrFgQLW4A9Gm0IhhO16+h/CrILGZBat5+zteZ1U+DzA3rTz9GQgMt4t9WdufVuns5zUkNbOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B3depReg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB3C433F1;
	Wed, 21 Feb 2024 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708504833;
	bh=7xitJWaFMoGdC6EmLXwVDyXLfZ/qyA8Ri94E+4oSwBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3depReg/IGMEtUNuDRiMZ2IiMTU9kg4eUCMLIafaOgPrEcPIb0N2BqxURQDkLZTW
	 JNwXF2Hn8lBCQlv0hLLvPFkns39+Oe43La/4jxTbRtPmWe9D5fI8v1PoqsiUs9SpN+
	 K7I4WTktlu4X8t+TaPf7TXK8FOvSL2PshK62RxQA=
Date: Wed, 21 Feb 2024 09:40:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH stable] memcg: add refcnt for pcpu stock to avoid UAF
 problem in drain_all_stock()
Message-ID: <2024022119-bogged-action-c877@gregkh>
References: <20240221081801.69764-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221081801.69764-1-gongruiqi1@huawei.com>

On Wed, Feb 21, 2024 at 04:18:01PM +0800, GONG, Ruiqi wrote:
> commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.
> 
> There was a kernel panic happened on an in-house environment running
> 3.10, and the same problem was reproduced on 4.19:

Now queued up, thanks!

greg k-h

