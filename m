Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F727B8D97
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjJDTqh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 15:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjJDTqg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 15:46:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2510A9
        for <cgroups@vger.kernel.org>; Wed,  4 Oct 2023 12:46:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4194c3cf04aso1109201cf.3
        for <cgroups@vger.kernel.org>; Wed, 04 Oct 2023 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696448792; x=1697053592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7a74Jso/OlkSlZMDwvvLmtQIl8s2lVAx0+yVbpXmMU=;
        b=08N+s2VQamUz9NrNZ34dGxGDlzaxioQHhaad2PYisk4GK1jWMLT71dWA429mcBBrjm
         nxh6UMuuhI1jz8g1/87aOiLNc9mbDxTa+t4+H22tHEHklaL8L9v2kbdqvynZAAz8sid3
         EVOJj1YM9KyD7CC8WmqeOJUet4Iu8Gva7CWWYMhTyalfAKSLSFC5vJgGf8R6xtam0a3f
         3Uu+TcbwyuxWBnFeHhkJvqpNMpNFYM0rkJ+u3cwxwo3dgKMJmf+HbdTYUA2UAka8SMYR
         BIp15X8Lefdai7ZMt9/UV7SUFcqKDlViipsZ7O6ZZn+EqLZR7VJfW3kzUQqoikgG1Doy
         5tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696448792; x=1697053592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7a74Jso/OlkSlZMDwvvLmtQIl8s2lVAx0+yVbpXmMU=;
        b=OV89Z180a92mDNgTzYhgD7zZAD9BvxMbRju6s0DmmsqvizfLX3GTLGGmKcWCx6puGR
         TfCrrPpBAugAPtjFLaWCjCzqb3Ro3xrL0tSqQGp6Ga1tlzfe0lJnOXqUUdLV+FKRsury
         yquwgQEY/ym5UjmAhtLsfL3ykWcxEFsrIjkVf/TPDycf0OSj3cUmxILXcR1S1dQMXQJJ
         8WhIp2Xy1gsbu9JcrRGXnQvqyxRwaH30jfBGHPKGckXP9DocYdabmN8JiXRjGGJNSYc3
         jIq1Mvb+ZE2qck5tmv1Ql8yv6vmgcodP66xyo9YYaGhcGW04CCSrjD7LFjpBv8qUSIhb
         tPDQ==
X-Gm-Message-State: AOJu0YzplSovfCG2BQAGBtJ66WJYQ/foPqjUou42wNeiVcFBcgIRIae+
        beMpphPnN/z7cFPoS6tzdzosHw==
X-Google-Smtp-Source: AGHT+IFPxxAKXEzdgpNycjPYLiqq1smMId8WtBWr0Vh0O58HwMmrxbd1riW468XFklK9cQ6MPrqGTg==
X-Received: by 2002:a05:622a:84:b0:417:a469:1680 with SMTP id o4-20020a05622a008400b00417a4691680mr3713256qtw.38.1696448791933;
        Wed, 04 Oct 2023 12:46:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:753d])
        by smtp.gmail.com with ESMTPSA id jr10-20020a05622a800a00b00403ff38d855sm1440504qtb.4.2023.10.04.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:46:31 -0700 (PDT)
Date:   Wed, 4 Oct 2023 15:46:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] memcontrol: only transfer the memcg data for migration
Message-ID: <20231004194630.GC39112@cmpxchg.org>
References: <20231004193622.900383-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004193622.900383-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 04, 2023 at 12:36:22PM -0700, Nhat Pham wrote:
> For most migration use cases, only transfer the memcg data from the old
> folio to the new folio, and clear the old folio's memcg data. No
> charging and uncharging will be done.
> 
> This shaves off some work on the migration path, and avoids the
> temporary double charging of a folio during its migration.
> 
> The only exception is replace_page_cache_folio(), which will use the old
> mem_cgroup_migrate() (now renamed to mem_cgroup_replace_folio). In that
> context, the isolation of the old page isn't quite as thorough as with
> migration, so we cannot use our new implementation directly.
> 
> This patch is the result of the following discussion on the new hugetlb
> memcg accounting behavior:
> 
> https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> 
> This should be added as the second prep patch in the following series:
> https://lore.kernel.org/all/20231003001828.2554080-1-nphamcs@gmail.com/
> (hugetlb memcg accounting)
> 
> and should go right before the following patch:
> hugetlb: memcg: account hugetlb-backed memory in memory controller
> 
> Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> Closes: https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/

These two tags shouldn't be here, but in the fixlet instead. This is
the dependency patch. Otherwise looks good to me:

> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
