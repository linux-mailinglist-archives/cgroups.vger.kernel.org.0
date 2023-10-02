Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467247B56B2
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbjJBPgM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 11:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbjJBPgL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 11:36:11 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D0FAC
        for <cgroups@vger.kernel.org>; Mon,  2 Oct 2023 08:36:08 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77574dec71bso480851485a.2
        for <cgroups@vger.kernel.org>; Mon, 02 Oct 2023 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696260967; x=1696865767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJCeoYI4MdW2Vg1VXnFe6BioTBJsiwn/a/IEZV9MrFI=;
        b=vmhao5zGzozZ7Ms8y+/iMIXIkW5zs6mPc+QueWp8R8ztfrH68bK7YxmfOZIvW4MsJQ
         97JXdAlh+bslIDvRiMqknuIuniFgZ8GX0syTc48ldbz8EzuRQpy1cos4amADigtVIlGr
         rH7kk4xIE52NJSdESd7AkzVIV8VuEu7MJPMa9zWd6H3RXEAOEXXLxyNsIiyTIuLWMjqQ
         go2MHlZLKJDTBvFxXapGQqyyzA4RMpozYo0JvKDiqVw/YFsjwHzeM8CUQGpH8Poim2OP
         +hzBNCaenmGTf1iFdZk17a7n96Eo2N9q2dBkDVQEDsEHW2hgilEsuSmJ5WkfI1CRNLBN
         di8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260967; x=1696865767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJCeoYI4MdW2Vg1VXnFe6BioTBJsiwn/a/IEZV9MrFI=;
        b=mHDohCdBWNvEB6UicoXCUDcWLfNsh4qqiTZ0nE2fRNuqWXJSGHwwSLHZMyrZSXmMQ5
         1ZNHVQgTDjX9buiLNpFLZnEa8Ck8MKpTGEpZCKcunMdrqIfJWmbCVGSafmAe0LgfRs6y
         b3UcKlarlZmadhxr+loA4v5Tq/45miquMIY1sNxmzPFCMEN7WJX89nEYyqcEwZrx0/bI
         gb0jLcyRKBH+WOIuDgJ61oaKw4y260n/5eS+jjEdbHYOXgcomVjtE52v2CMw5nDPrS8P
         o486TBWkLqhk24UDFT6XQsSd93OMuVYyEbMc8y3TKWaw+IOYYgSNkyzvszrt6K7V1UNR
         fEKA==
X-Gm-Message-State: AOJu0YzTr8FgQnSRQVrphX7kEb+QEg5WUXz7VITG4KFmU+7c2bw+3A0V
        ZYZWLYsS8lP9rYvCaXXRSQ5zQw==
X-Google-Smtp-Source: AGHT+IFF7jCfjDq8C5HlvxijPDsuuv1R1dJYVyC0Ykg+iTQehAD8V0XEHiC5mEXTWNubAjbj8/02RA==
X-Received: by 2002:a05:620a:29c4:b0:775:6a78:5f9a with SMTP id s4-20020a05620a29c400b007756a785f9amr16126546qkp.6.1696260967363;
        Mon, 02 Oct 2023 08:36:07 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id h8-20020ae9ec08000000b0076e672f535asm8992682qkg.57.2023.10.02.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:36:07 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:36:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, yosryahmed@google.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <20231002153606.GB5054@cmpxchg.org>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
 <20230927184738.GC365513@cmpxchg.org>
 <20231001232730.GA11194@monkey>
 <20231002144250.GA4414@cmpxchg.org>
 <ZRrajQSHrwNLnXSe@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRrajQSHrwNLnXSe@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 02, 2023 at 04:58:21PM +0200, Michal Hocko wrote:
> Also there is not OOM as hugetlb pages are costly requests and we do not
> invoke the oom killer.

Ah good point.

That seems like a policy choice we could make. However, since hugetlb
users are already set up for and come to expect SIGBUS for physical
failure as well as hugetlb_cgroup limits, we should have memcg follow
established precedent and leave the OOM killer out.

Agree that a sentence in the changelog about this makes sense though.
