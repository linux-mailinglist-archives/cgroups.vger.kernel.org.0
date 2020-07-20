Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76898225A47
	for <lists+cgroups@lfdr.de>; Mon, 20 Jul 2020 10:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGTIny (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jul 2020 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgGTIny (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jul 2020 04:43:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B2C0619D2
        for <cgroups@vger.kernel.org>; Mon, 20 Jul 2020 01:43:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z24so19308811ljn.8
        for <cgroups@vger.kernel.org>; Mon, 20 Jul 2020 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ktede3490cF8xrICApRVvg9tnZvpytnPociFCS3lvDc=;
        b=e6djTCYWEj2Fmi95lUFWKgkZcJHCyeTSf7Syl643UoYLetz7sglV0iZEAzz9bdhAWy
         AV2kduveWFWI+JWAlK2oNtidKKo/CEuAaKD0MJ5Pp2tRK5UEZOnqUQB+URJ8qpBiS3E0
         7BLXT/fa/imiZu0Qgtj10PZL/JBmO+Pz1dtSqFtftbPH5ryJlZX1B4ohWJEXiBEEvDCm
         QXR5JmQwVkqYm8SkgaPhzlXf0D9fpQhWmfdlnKXyWsNJSVXFpVk2mp2087rkuizdb6pR
         gp9yJayr7YSyuNloyVlOeoyOmDejlgs1239X59/cPzNKO7ss8eXDNgChuv/x7qWhxATI
         9lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktede3490cF8xrICApRVvg9tnZvpytnPociFCS3lvDc=;
        b=PWOZkIRNCnTlAbJeH8c7bYSnQu+MCRA8+5hBtSnojskqiwPpNNEf3XPl5I6XyR1A20
         cct6XS2gZ+/PE/KalmNloxkVCPauw5eTnQ9Lo/nU5sZqHDXfrrhtfqpHlaMBeRf5TKFj
         yfbswZUO3oJKIZeblJJsIeb4OSiEOHNFs8VOMnNUWD5nIsN/JUhTIWrRutddp4JgcUq7
         Jo7dYMU1lkj2r8tL940xrRsybKbCNF9hg6SlUC9EIul8cysMY4lxzFRsNC6TBMwW/Syd
         tq8U+e88LUTX3rH9HrA8P0H+uGiMnmSQl8aCQ9Lgg+CfXhUxjdpibp++fgcsynvtYSC6
         brvA==
X-Gm-Message-State: AOAM530Gj5qu+5jCO6TYJ8377A/p4nPFnOej1h974FO2fun7CpJimVEw
        xw39bHML8FBRAQOS2WYYYsD4uA==
X-Google-Smtp-Source: ABdhPJxDpc+xGL9gCU4hB6aJTaR2Pfe9WrNdwYB5SAzencPCUUdqx2ZecSSoIxaZ/WyEMlHA9/Z3Zg==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr9133434ljm.116.1595234632369;
        Mon, 20 Jul 2020 01:43:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s62sm3101085lja.100.2020.07.20.01.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:43:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E7866102393; Mon, 20 Jul 2020 11:43:51 +0300 (+03)
Date:   Mon, 20 Jul 2020 11:43:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v16 06/22] mm/thp: clean up lru_add_page_tail
Message-ID: <20200720084351.v3skr3pluudy6fer@box>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-7-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594429136-20002-7-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 11, 2020 at 08:58:40AM +0800, Alex Shi wrote:
> Since the first parameter is only used by head page, it's better to make
> it explicit.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
