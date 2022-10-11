Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFAD5FB8E8
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 19:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJKREk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 13:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJKREj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 13:04:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06A1E5;
        Tue, 11 Oct 2022 10:04:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so16635892pjq.3;
        Tue, 11 Oct 2022 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqdmtqa8RE2RmAZ8iS4FrD0zV6hOcJCc7nr3ARbwfwo=;
        b=aobhvW0vOctc/TvPZkx2hfVLoinJiY0qIbvrUd1kge95Xuh9Z9WlI9w0VDygXONgEx
         SUHOQHTOXNeisew1HS/vWSWZA+IgCMmsEyc746xUu1JJM1zCI6OZyo7TnWVyWPqRr4ob
         uwOik+kHtFEScp6ufvKxNT6l1i5WWyjekaVk6wH03OuvEKHh7Ywm93IdoY23xT9Hiv9x
         shYjb1VDVYlnBZZOCjk9zqid65aA+upc7jlbeEXs0KbtmYudcuvpijrFv3/keO+W2NDB
         /dr6f9dIxCUVXZ+KYUqFai8jHP7V3q21jp3JHSleaWUqKqtagiDjH+27yTxq8oMCUZyR
         ucJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqdmtqa8RE2RmAZ8iS4FrD0zV6hOcJCc7nr3ARbwfwo=;
        b=U81SFLG6ywh5Hf1OwJbPVZYWp7dUTxr0CzQXFPWA/0kCqcSMzpSKk3D2la4j3H/JZH
         xMTHeSAuuW1RwlGju2btxFO+S3BOnhu4AdYNFLMPzegoEgEAzDpU8JVrbRowi1Zx3InE
         iIalqjpeUP66Va3s4YDkeGR9iuu6Y/0CqVM4nHS6wfKsgiiLr0Rg7S9nCWuzVJ3peD1i
         svavUK3sklHXGaGypE6IwHEShSID7OKuhF3d3Ho5WGGDXdhdTpaDfHRQJXGf9n+A73/x
         DXsnpsRxDLF7+Sb7p10BdLHJqJNbRRj66O55uQWx50+OZmbo7g1iB2FJnVYljh9oRY8w
         a3KQ==
X-Gm-Message-State: ACrzQf2d12WKnp/QmMhjc3JIX7ceSDBCIWI7zT0R6LWEXlGKQJ0aFuiD
        zy1toI3EPbgXHBDRqzTs0GE=
X-Google-Smtp-Source: AMsMyM7dElOPZoUH3HZbgCT8GVyl16joalp1GcedLIX281yzL796sfmwDcPZz19aAf9oFCNnqUcHEw==
X-Received: by 2002:a17:903:11cd:b0:170:cde8:18b7 with SMTP id q13-20020a17090311cd00b00170cde818b7mr25261286plh.165.1665507874322;
        Tue, 11 Oct 2022 10:04:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x10-20020aa7940a000000b005636326fdbfsm4406789pfo.78.2022.10.11.10.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:04:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 07:04:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm/memcontrol: Don't increase effective low/min if no
 protection needed
Message-ID: <Y0WiIDmPPXYZuHpX@slm.duckdns.org>
References: <20221011143015.1152968-1-longman@redhat.com>
 <Y0WOPZxWSnUjzZ8e@dhcp22.suse.cz>
 <defdb421-342e-ebcb-d7f0-005559dd1e0d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <defdb421-342e-ebcb-d7f0-005559dd1e0d@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 11, 2022 at 01:00:22PM -0400, Waiman Long wrote:
> You are right about that. An alternative way to address this issue is to
> disable memory low event when memory.low isn't set. An user who want to
> track memory.low event has to set it to a non-zero value. Would that be
> acceptable?

Wouldn't it make sense to fix the test? With recursive_prot on, the cgroup
actually is under low protection and it seems like the correct behavior is
to report the low events accordingly.

Thanks.

-- 
tejun
