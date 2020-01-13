Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63427138C6A
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 08:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAMHgO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 02:36:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41284 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgAMHgO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 02:36:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so6068730lfp.8
        for <cgroups@vger.kernel.org>; Sun, 12 Jan 2020 23:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LuCWDSuVOHVDD0RBreB5I3crH+JdvuDeEnJ61QwIlv8=;
        b=lxxn4P4HGDQDftUPfcUemr7aW0pZLgel+N/hMr05xUbY+zyc2C1asmbnF6WPrEe2Cy
         u1IDuJpghF8gQzagcU0NMmHaVJC4muTGR1pTq+v9V9/kzo0AEL8uqQb9m4VJEi1ytNbR
         G2HU5EagSfAV5/K8u7iszKZ/zUWBPWWrMfDsfYJqp+POEF4FBiF6PsF2vJY/LdmBUb2j
         xeAI5U+PGhP0ScNDzJRKW7lGHn3YqkFDMBvv0mCjjIFr88NXimk4yZbuOwVeyrfXUHr/
         gFZvAgDZdLT4fuqPJ80e4hLpWqQmNcRTbeJPh3JigUeAuGHwaXOFEy3/INoEC0+kn/lD
         cHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LuCWDSuVOHVDD0RBreB5I3crH+JdvuDeEnJ61QwIlv8=;
        b=j5mbpsc6FQ0DoOKj/bYI0OaIFVdfCCYnkWfWbOAvJlhhdRqaCdzapBVM1KKX0PmFXc
         4cPIAUO6EkGX9kwRXx8TRe3UNPqGvhLupN25vzyJeV310jsAzRmdDuYuGDHQu83gd79c
         77qG+vaiKcbdVCvFCiIe//rVi7TnthJDjx0M4YJGOBTpqI9haRpN+4BbDqIZ4/XiztBx
         jysNZm1FgliesVg202RxhiLK/JCv+Qv9DTxdoZEk5CrJbSXUru6Lnarz6LeboJ3bOe45
         OkiAOkO3MNFpvsOFkhfK9jM2xTBHhO3+hZ5eb75nmN9p3DDcIpJMeP+TlLZT3KZEBvt4
         Mdew==
X-Gm-Message-State: APjAAAUWOmR31NGn+kHIXH69ypbpp1ITa39P3InOtfIKOIpMWkdv16gC
        5y8q2/x3EHd549ebXatP89SP6g==
X-Google-Smtp-Source: APXvYqzpxmHesE/c6JuNwGxLjvBVFrG/i69Jzm2Jvf0XSNKN28YoqY5Exph+JvJFaL9arlLhJ+stng==
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr8925268lfo.36.1578900972267;
        Sun, 12 Jan 2020 23:36:12 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s13sm5455116lje.35.2020.01.12.23.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 23:36:11 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A8B1E1008E9; Mon, 13 Jan 2020 10:36:14 +0300 (+03)
Date:   Mon, 13 Jan 2020 10:36:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        alexander.duyck@gmail.com, rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200113073614.jo2txcmazwlesl7b@box.shutemov.name>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
 <20200112022858.GA17733@richard>
 <20200112225718.5vqzezfclacujyx3@box>
 <20200113004457.GA27762@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113004457.GA27762@richard>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 13, 2020 at 08:44:57AM +0800, Wei Yang wrote:
> >> It is possible two page in the same pgdate or memcg grab page lock
> >> respectively and then access the same defer queue concurrently.
> 
> If my understanding is correct, you agree with my statement?

Which one? If the one above then no. list_empty only accesses list_head
for the struct page, not the queue.

-- 
 Kirill A. Shutemov
