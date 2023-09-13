Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5179F3DE
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 23:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjIMVdu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 17:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMVdt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 17:33:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDAB173A
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 14:33:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41214998fc2so1385821cf.0
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694640824; x=1695245624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S915mKK5+DIHTjSPmbc01fyab6FvzQ8To3PxTMKLA8Y=;
        b=nNEi+6uoJJf7OhHJUwN5KAPquj7RSqdV2vhiktOT03QDmjIqaF2Rb+GJLlsismu67U
         nIFDPARnQSg7VpcfzbkAZukhzvVI//9ObTvszQdup9DvzJLZFlpd8yqW9aPPjnfrR0MV
         zJiniceuKYgxnFJFTQs6JxvULYgbsj/lmx8KSOoJCoG2P6MnLazOWc8LyHjVqS35IP0i
         nkoarEZLfKhFpjyHH+P0/CJdc1pSHCHaqsELC8qJqYD3RuFs16Ko+TH1fodvSA7D6Li7
         luwj4P1NY0W7M1CdT2LFmzQQMfp2wbJD6+ni22oJnP89JsE7sBIMdum/+eY4P0za/9it
         cIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694640824; x=1695245624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S915mKK5+DIHTjSPmbc01fyab6FvzQ8To3PxTMKLA8Y=;
        b=FXHQANzjQ1svdlfqeDH1yi4K45UA+/33qfmhRP0U7iXl3V5cizVHpwscvOiidHUvyM
         d5xegSinvpXSUAt2eyzMylJwvbGKYFuiDssRoz42fUK3HfXQqyzMUcpZN3YojfsAA/ni
         xAY+rNwF9BLvnOjzCeQ4bkQU3pmnBcRINL/0qR1D8kpajNvsXRgzhV+Nnvsj9ogGHxzx
         SKFNLxymzt+XGU7QbqZTpIbQRMe2OxjWHCUUb8B4u4YTfLqn/yfn4T3eXP6i3lRp6c9B
         NkejpSMujKcKtHeaqWkh+GEnI2jjgtEhTkrlMt4Req9/kKYETgTpbhJFjG2iSLqAxvE8
         qopg==
X-Gm-Message-State: AOJu0Yy+QTo9t5r8/dIR2CVLyynuvpwOzfnHLHrhC2ZIp8YTrPea66Jp
        QZbrYnWkiVoROKzW/5+uhYVZtw==
X-Google-Smtp-Source: AGHT+IGj+kyFClqGaSCr+a9vcw6r5z/yulRoGnb2lHWIW6UVnEUsPPXQyQJpiOCcHgO3CkYJ6FqD2g==
X-Received: by 2002:ac8:7d8d:0:b0:40f:de02:8315 with SMTP id c13-20020ac87d8d000000b0040fde028315mr3437193qtd.7.1694640824612;
        Wed, 13 Sep 2023 14:33:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:35bb])
        by smtp.gmail.com with ESMTPSA id o21-20020ac872d5000000b004120400921csm47884qtp.94.2023.09.13.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:33:44 -0700 (PDT)
Date:   Wed, 13 Sep 2023 17:33:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vern Hao <haoxing990@gmail.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xin Hao <vernhao@tencent.com>
Subject: Re: [PATCH v3] mm: memcg: add THP swap out info for anonymous reclaim
Message-ID: <20230913213343.GB48476@cmpxchg.org>
References: <20230913164938.16918-1-vernhao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913164938.16918-1-vernhao@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 12:49:37AM +0800, Vern Hao wrote:
> @@ -296,6 +295,7 @@ static void swap_writepage_fs(struct page *page, struct writeback_control *wbc)
>  	struct file *swap_file = sis->swap_file;
>  	loff_t pos = page_file_offset(page);
>  
> +	count_swpout_vm_event(page_folio(sio->bvec[p].bv_page));

Argh, this should be

	count_swpout_vm_event(page_folio(page));
