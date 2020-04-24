Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F631B6A4F
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 02:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgDXAaT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 20:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXAaS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 20:30:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E8BC09B042;
        Thu, 23 Apr 2020 17:30:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so3928664pfc.0;
        Thu, 23 Apr 2020 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BDMXkjuJWWuNQzKMsS1orlq7kdCJZm3J8FZDWv+qlIo=;
        b=o8xbquq9KICTnRce+ky9YCyMckMeUWhi8Xgq0sdLPa9JJ3xD0B99Ss0XfHcSns/6vt
         SyaTrgG44YUlVKA6RkxQVXGp2Ne7pCoT0cpGFWClnwgk2sl9eHQIev2FeUZ6+jtPPGo3
         JAhCT+gVfYx8C5ggBnwi+71vv1iXRSsfeq0Sp1dMYm8X+iLv11nZTQSKa0mc9Nl93ni2
         S4C9loWLUqJnfdrFCEco9+ySBD671KSQB82g8xwDHDr5lpeawq+MTG6uA5Jl2JfDHpQr
         C0jUHCe9vhbv26mDKTtr9uPP2NyjiS9631OTwyVZIR//C0O7vYWO0YDxxBx5LTipmP5S
         /t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDMXkjuJWWuNQzKMsS1orlq7kdCJZm3J8FZDWv+qlIo=;
        b=djOT2xI/W/koWvIU3YOCl9i0mIQMk9VHbsyEx3dWkx3J2YRUln9WrB32ElvwoMoFTn
         OcrVQjrh0+1QJ+i58oiT3xPyOmniQvuaf4djkxfgUbzEbXnTxDbrAENy3KezAnrJtPjh
         mLp8LsHgT6wsfc2QnUp3WsDKcqLSDPN2LpSSKD7V03JAw19EoCslKH5pf6QFsumXWC8g
         ep7wcG8MeB3ENtfKO34DsCKMaQYwK42dr7YUqXzM12xFSQigt3fzZiTvUTzZLtZWQA7H
         m/YmzM9W2FcdjBzl1dEnrpb48hfjsD2hqbER9+JQ38AyEq3fezlNl9H8w01ZD3t7Kh6w
         oQnw==
X-Gm-Message-State: AGi0PuYIelIxXqc17tY/JRLGvKK4kbxXjk0nlq5u/j1oYToJ6In3oatk
        ZyzPFijSrTS8Ak93d5p2ek8=
X-Google-Smtp-Source: APiQypLyjLfnOmDpZQadgott9wyBeL/bbOQ5Arn8VDDQpG74JHwXiSiCwn7Mee5aiDxuN/RXadGDAg==
X-Received: by 2002:aa7:9f5a:: with SMTP id h26mr2964674pfr.281.1587688218288;
        Thu, 23 Apr 2020 17:30:18 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m3sm3279420pgt.27.2020.04.23.17.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 17:30:17 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:30:12 +0900
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
Subject: Re: [PATCH 13/18] mm: memcontrol: drop unused try/commit/cancel
 charge API
Message-ID: <20200424003011.GC13929@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-14-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-14-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:21PM -0400, Johannes Weiner wrote:
> There are no more users. RIP in peace.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

