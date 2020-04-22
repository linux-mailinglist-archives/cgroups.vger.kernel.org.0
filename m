Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40E1B378B
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 08:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDVGeX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 02:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgDVGeW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 02:34:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4FC03C1A6;
        Tue, 21 Apr 2020 23:34:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b8so573795pfp.8;
        Tue, 21 Apr 2020 23:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cNPk7dyrNsunZ6orqrkHd3dWM4T8VDBKi6CmTIj2FrI=;
        b=M2VzN4hLhiH0xZ3XfNmNlGsb5z71UEM7bOyLibiJrUfqzWnsr7Mnho6vtHE/m4Si0v
         lnCn+vZHkutsNSoFUaoObLyQiQSLmg2E532x3z54L9M827P0YXucnSwhA9qoFbPgLZYo
         6Pnn7OD2T+2mft6/ZrVBqjr0Z8Ia+jWOrzp/UEJQUDs5z096V3X2fOD5cVO1szM/Osar
         MC4rKQaH88JrQvya16KDxQlKEJnatD7NZPCiq5AMNNXi5TrKQHsT+Y2049Noj50KK5GE
         xNN6BnnrnU38ST/mJuA5+lzdnq8CaNQK5ozCSe1BGa4cBaHzURGRTJKAOhW/d2ZL/Ba4
         lD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNPk7dyrNsunZ6orqrkHd3dWM4T8VDBKi6CmTIj2FrI=;
        b=FYwqDUEXRdKR+PlJP2TlcoJKQHtLvjDHkebc7d7maI8S8A6IGgd+eWKxEsbmAwdquu
         t9amFRtJbh/pnneCn/IQJUo0/nMUXVTlVU7QjJWChBxoYwzsEv2E4XYo0Io81nNdi7wE
         tNa8Ykhe2fNuq+RlUOLTCAegj1yThfHQFa8GZxl1/GXQVC9thMCI5CRpcJ7TziqYBOwZ
         sZLCTrPr/pH5W4VTC/UtYEDSjZXC1uU+7VOTgYBtmBLWMaHZPdudM9MBydzZoSStsiqg
         4SnA2e3tC4IlMddMl6kyy8JZ+RVb/Cgapa4hqwJzg2CSluOOjHpePUo3iFtVZ+qe+RgT
         CrJg==
X-Gm-Message-State: AGi0PuYPJxDtn6O2av7GMLXsM1Q39tjh46hrsLJZYqymj6VGJ5DCZmMV
        tN39aYRErWN9C//UoJicpYA=
X-Google-Smtp-Source: APiQypJP4b55YW0Xr4yN/i1f5EJtGYDB6MWrsPNzg/jfdpNKfoNyvy6w6+Inzdjw2v98RvW4I4Yapw==
X-Received: by 2002:aa7:850f:: with SMTP id v15mr24807543pfn.204.1587537260883;
        Tue, 21 Apr 2020 23:34:20 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id j7sm4417821pjy.9.2020.04.21.23.34.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:34:20 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:34:11 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 01/18] mm: fix NUMA node file count error in
 replace_page_cache()
Message-ID: <20200422063357.GA6780@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-2-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:09PM -0400, Johannes Weiner wrote:
> When replacing one page with another one in the cache, we have to
> decrease the file count of the old page's NUMA node and increase the
> one of the new NUMA node, otherwise the old node leaks the count and
> the new node eventually underflows its counter.
> 
> Fixes: 74d609585d8b ("page cache: Add and replace pages using the XArray")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks.
