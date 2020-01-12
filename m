Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4AE1388A7
	for <lists+cgroups@lfdr.de>; Sun, 12 Jan 2020 23:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgALW5e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 12 Jan 2020 17:57:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36045 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgALW5e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 12 Jan 2020 17:57:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so5460335lfe.3
        for <cgroups@vger.kernel.org>; Sun, 12 Jan 2020 14:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YhEnPWc7hBMgzTi8jrnUahHh/j3JJLesjhzD86DLwCs=;
        b=17mnMprWe4+SB2cTaLQImgJbVUQMzsjRXuwdjTe6KETCHH94Zi6GGwUo5/WsHFRbJL
         /NAoOp0F4Dj8T562fMLT2GENv5UucZ+oCPCg5+TMX0LVwjxzaxeNMIfdloCgKwLQ6QYs
         +aw6FaoTAN1olVQlSVat6zHRBfOtwJH4EV0K9WdxN9TvaTkUxjahKqF3aEHkUp4DgWjE
         ISIP32ImjX7TZHNBYrb04W84s7tWZ6Sr56cznaStx43sgf33DhEwl8jkvJd2ZBZ8vHkN
         2Kck6f7sk1Y0y5vqhxkc+AODNs15YZjkIJf6xKEGBk1k6iBEWZkEVuqS6cyWL9xrpjCD
         7BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YhEnPWc7hBMgzTi8jrnUahHh/j3JJLesjhzD86DLwCs=;
        b=SyrAefYetqEQvAja53TD7IupyRjHEos8rrSZ2sYGAF9BBtCnc66hXd3HPqg+95mmOF
         Mswx3qJPWJDwz+9+LsbzGyykfWwGlhIfyVEmrYeUUwLgkb2QaPkyf56Yp5XxR30DncMS
         nVhxOwPlAaWNjKJgVdfaL9kgiHgZCbl254sue74x0jrRpsZwL+uA7cEbBmvoiEgkIlhV
         Rh+kgQmZocEn/HwuoTOfDAiR8eyu1mqgjS0DvEt4AgtuB6KL43RvWlEeazxcuQE2BlRP
         u2EGsQ7AatekWhKf/wRnptwkfnwiZqa8GyiOdgcJurdAw3UMGS7LFiFVsKm3tCWXvg+8
         hxLA==
X-Gm-Message-State: APjAAAV7DYe1Sy+3EDvaoXLQp34zH+e7vEIqx8y+1n2voumL/3yt5Cqo
        yrO9d4zSe3A8Q61y7GywoVV03A==
X-Google-Smtp-Source: APXvYqyI3dhoVWz1rlW2tbfefaOwjJIzY3iO0lO9eqrbCp4ajUvL39rdjB4jk+LQl0B9QgQR6EZbCg==
X-Received: by 2002:a19:c3cc:: with SMTP id t195mr7915631lff.144.1578869852309;
        Sun, 12 Jan 2020 14:57:32 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r6sm4849697ljk.37.2020.01.12.14.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 14:57:31 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5BF79100376; Mon, 13 Jan 2020 01:57:18 +0300 (+03)
Date:   Mon, 13 Jan 2020 01:57:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        alexander.duyck@gmail.com, rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200112225718.5vqzezfclacujyx3@box>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
 <20200112022858.GA17733@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112022858.GA17733@richard>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jan 12, 2020 at 10:28:58AM +0800, Wei Yang wrote:
> On Sat, Jan 11, 2020 at 03:03:52AM +0300, Kirill A. Shutemov wrote:
> >On Thu, Jan 09, 2020 at 10:30:54PM +0800, Wei Yang wrote:
> >> As all the other places, we grab the lock before manipulate the defer list.
> >> Current implementation may face a race condition.
> >> 
> >> For example, the potential race would be:
> >> 
> >>     CPU1                      CPU2
> >>     mem_cgroup_move_account   split_huge_page_to_list
> >>       !list_empty
> >>                                 lock
> >>                                 !list_empty
> >>                                 list_del
> >>                                 unlock
> >>       lock
> >>       # !list_empty might not hold anymore
> >>       list_del_init
> >>       unlock
> >
> >I don't think this particular race is possible. Both parties take page
> >lock before messing with deferred queue, but anytway:
> 
> I am afraid not. Page lock is per page, while defer queue is per pgdate or
> memcg.
> 
> It is possible two page in the same pgdate or memcg grab page lock
> respectively and then access the same defer queue concurrently.

Look closer on the list_empty() argument. It's list_head local to the
page. Too different pages can be handled in parallel without any problem
in this particular scenario. As long as we as we modify it under the lock.

Said that, page lock here was somewhat accidential and I still belive we
need to move the check under the lock anyway.

-- 
 Kirill A. Shutemov
