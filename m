Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2482223B2
	for <lists+cgroups@lfdr.de>; Thu, 16 Jul 2020 15:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGPNRD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 09:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPNRC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 09:17:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7D9C061755
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 06:17:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q4so7153634lji.2
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W5qvqp7i9pGe/AtHlHz71cVG+5e0FG1RqQpp4GXhoLM=;
        b=sIftRPRG702Z1I1WOW4Fzuf+q99t3ZflmLuikxRMy5BxwR0rtDQ16lcc/wpZ3zaPfU
         yMdgtl4RwI8M0PSkF3LcuQvwavEbpcbx4TUOBXfMTe+wfyULYrlrepSZYODe7HQCfki7
         JbsA+W57eVgW34ZS6t67KVCbO6UxCDukJgodJ6CyglTzJIaewo9slKd8E+Nuj77eawRf
         8qUFkBsvMta/7L/HGyaqYYJdtijGwphH7Kqv/JfBrPMD+SepIiIpalUXgHKSfeUlpin9
         iPvn53qhRGm9DxvI8JvUml+5VbKPW+xUIaebJjYUXWjBaGPieygJ1q6h4gSUihCKtLgl
         d2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W5qvqp7i9pGe/AtHlHz71cVG+5e0FG1RqQpp4GXhoLM=;
        b=JpJwWhSA3+ylWasKht7tDCevUVmafepG6O4lKRG2u25GE+5nBnk2ZXR/A6395nZwDs
         8exRQOqRVB1cW/svde6yNz73ggLbrJk0Oth4bkbYYoDX/282SHNSp6ZkNqdwaSzLhKxl
         K2ZPG0aK5w200DtwYvQOKThwtJiHgc1hW9gSVaMl5RhENe80Ris5zd9A97v5KC6OZra9
         Rhwh9W5cdSO8cVCqMKbxD/BRM6jkunjJN2aCpCr85Mv6KlC1uM8fimJEuoZED2vcYW9K
         hnBgvJUK6CwQ7l6BfhcVUQWHxvQkN4glNleJCAYW5sLWQxd3Lokm7UYMRW/HDV1Ems6h
         NHKg==
X-Gm-Message-State: AOAM531RxlRWDujlEZN9Rnc0BOYUMAqgWBbVyuwTJ8kbUAj+itqvgDzN
        drlu30A8Uz6conH1COmMayoZcg==
X-Google-Smtp-Source: ABdhPJx2+owb73fQ/D4FeUCKaDliqhWjIyO0fRPipW5Ly6Tr1wDXXJj32vmz37eS+aB9Y+DT6iqbOg==
X-Received: by 2002:a2e:9857:: with SMTP id e23mr2132595ljj.411.1594905421188;
        Thu, 16 Jul 2020 06:17:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w15sm1176686lff.25.2020.07.16.06.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:17:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ABF391020C1; Thu, 16 Jul 2020 16:17:06 +0300 (+03)
Date:   Thu, 16 Jul 2020 16:17:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v16 05/22] mm/thp: move lru_add_page_tail func to
 huge_memory.c
Message-ID: <20200716131706.h6c5nob4somfmegp@box>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-6-git-send-email-alex.shi@linux.alibaba.com>
 <924c187c-d4cb-4458-9a71-63f79e0a66c8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924c187c-d4cb-4458-9a71-63f79e0a66c8@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 16, 2020 at 04:59:48PM +0800, Alex Shi wrote:
> Hi Kirill & Matthew,
> 
> Is there any concern from for the THP involved patches?

It is mechanical move. I don't see a problem.

-- 
 Kirill A. Shutemov
