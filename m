Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA94EB3A4
	for <lists+cgroups@lfdr.de>; Tue, 29 Mar 2022 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiC2Sqr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Mar 2022 14:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiC2Sqr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Mar 2022 14:46:47 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B600996B2
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 11:45:03 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t2so16080190qtw.9
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wi+z/Z9+bTszOAA7rHqOmh583Mg3TQkFi7JSYo9ywi0=;
        b=DwNT+z168OYtkjIr+3YCZrHs8/3W8IE1Nl0ty4mFkqoUDo8tf/szSLaUNSBXl4Wylr
         Igz08zwV1POftWtcpP3Bg9dRpjC2RRSOARXxLj9LV4vleyxni2gXse3o/tneb0GkxVR1
         GCA2Y3WWhVwBgW2rUTm8tE1d1SzrbK6SoHglCm6pJffhbfr7ci5KCpwrDi47fafYM6LB
         f57gl5NCEh0wf/vyVx/1AKldB1o0JblAPOMNQRGw5UgkzN55gvhp7EEEhbwNIrdlMBHv
         5E/5+odSEQc2tVHazcmLF2OlWqY0zC5BtLU0iJ4rJiBNMb65yV12mTS9BjnBpF8yy3S/
         5QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wi+z/Z9+bTszOAA7rHqOmh583Mg3TQkFi7JSYo9ywi0=;
        b=5qArBEcO0wJa/vyOYUJhXwTvOyTTSrjl2lGiOOfUFwdTrNc4tSfR8FrDNjzaYjbiVN
         rgSVEniaznjyFuIOeXe6Grnv2MeEOvBwBKrSZIZ0D1gOcOtGmenfw83bg9HoEc/EPvJR
         39sF4U10aGt7FqvDngP7vvW0SwE+GxcdQCAXKt2bDcC4iyF3RTluCMFAgLlMNOVD/HV5
         6smNJlzYoyvr3J8+VPntUWhpjXxjpVHi5jc95lWfjLQyq1yhuWwWBl0bE9cMB3RzX4rI
         mJtRBROY0hDnPQtckJFPCB6jY6yUVW31GrdO666VDouzG3tSKmhRKpcYwTayAYsX0d0Z
         uPrw==
X-Gm-Message-State: AOAM531LlZ1kL6lnqt4qcgHunsCBQCvuQcX+UQunzG/zWQDBdt8xxeuC
        rKE0n89gx41QLeepDWIubqqfPw==
X-Google-Smtp-Source: ABdhPJwSTjTNxXsOw4FBG8xyjCEmBoTqu+lMCjibLNT0+9gsPfCjTuqpPav9t7BbrjayLMVz+QwDbQ==
X-Received: by 2002:ac8:5706:0:b0:2e2:3401:49ee with SMTP id 6-20020ac85706000000b002e2340149eemr29424944qtw.534.1648579502103;
        Tue, 29 Mar 2022 11:45:02 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id a7-20020a05622a064700b002e238d6db02sm15916292qtb.54.2022.03.29.11.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:45:01 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:44:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/memcg: set memcg after css verified and got
 reference
Message-ID: <YkNTlTKnN63r6rWC@cmpxchg.org>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
 <20220225003437.12620-2-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225003437.12620-2-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 25, 2022 at 12:34:35AM +0000, Wei Yang wrote:
> Instead of reset memcg when css is either not verified or not got
> reference, we can set it after these process.
> 
> No functional change, just simplified the code a little.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

This looks better indeed.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
