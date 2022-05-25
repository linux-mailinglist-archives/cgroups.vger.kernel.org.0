Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BC533BEB
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiEYLoi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbiEYLoi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 07:44:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB20AA204D
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:44:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f21so6640741pfa.3
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nCNfEzGqMIoFCilTHapRIVeS9mBRmJZJ0gWnXehqDrw=;
        b=KKorYnAd9m8FFqkZWn1KRNBoG7l7TplARvR9C9P62KHQROZ+jCx3jrm3pqL/gal3c9
         tFxlYeVI5en3DpBcz9uCwkckr9YIthe+s0N26u6nJlmW2jp2woFwMCKEv8tbOJ6Ue3TI
         WbS9a4byWlYC8V9D8SCd2meKPqDE/U0FTn5968T/hQciYJlyiEq9tZ94pXPADWkvFk0j
         eBCLDxzMmIeDgmSoxpS+Db6wfsGf6U2Vh4SNWSSt6qCjruPdllqx+6OFrhWa3ZcNnszL
         b/ePL8Ohf4qX+HlckCZ2au3uCxyAFMSgsiIR8AcKFf1o7nK3X+9eTEmBH7FOmpCbJ/vp
         WKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nCNfEzGqMIoFCilTHapRIVeS9mBRmJZJ0gWnXehqDrw=;
        b=mABwPZLcgkGJZ8WYkH6EyVZSB4aWgayLRhySv3LEAlfb1LBtzsgFtEGHaHc2bP60AD
         4uNzRgMJH80f0Cj0eN55wKDSPnD7tCIvRBnNSSmBzNEFAUCZ9e6jcdKEa7Kna66GjF0a
         f5MDFPs1dLqAIuPQdTYgf4HcSpGeCuFusT39nLOfs0nNm71QxpWuGl17fbzTWBcGvcHN
         OpayW8MuVtpbM8AblJsKN8ztctvHtPSqzqItDEL/jFFqjPPf8bY6uUVv3faIVFoyAQ0t
         qiU1s91zwcbkv4UVkJY2TjxfwZCvoBprj0bg6D/L5o1XuSuJMVey2MxPzmshYgPTFnaH
         VHMg==
X-Gm-Message-State: AOAM531shlv9I8jXEAzwQLSkih5/Z6lqsmLFxFH2YYe2riRx6gviWVpb
        v9pkLrrWDNuGTuRAPWtBy7KXOA==
X-Google-Smtp-Source: ABdhPJwECqnEoVXXBBz8+x+EnBqP+BiRhIpyeDXKNS2lypsKKNocA6JT73IkkBBWb0ZU66Vx2+IUag==
X-Received: by 2002:a05:6a00:2353:b0:518:96b7:ceb8 with SMTP id j19-20020a056a00235300b0051896b7ceb8mr16934713pfj.5.1653479076348;
        Wed, 25 May 2022 04:44:36 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090ae01600b001df666ebddesm1406580pjy.6.2022.05.25.04.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:44:36 -0700 (PDT)
Date:   Wed, 25 May 2022 19:44:31 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 06/11] mm: thp: make split queue lock safe when LRU
 pages are reparented
Message-ID: <Yo4Wn7IBdNBR8dWx@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-7-songmuchun@bytedance.com>
 <Yo2aa661fepAOvjO@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo2aa661fepAOvjO@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 07:54:35PM -0700, Roman Gushchin wrote:
> On Tue, May 24, 2022 at 02:05:46PM +0800, Muchun Song wrote:
> > Similar to the lruvec lock, we use the same approach to make the split
> > queue lock safe when LRU pages are reparented.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Please, merge this into the previous patch (like Johannes asked
> for the lruvec counterpart).
>

Will do in v5.
 
> And add:
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> .
>

Thanks Roman.

