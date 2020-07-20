Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731F3225A2D
	for <lists+cgroups@lfdr.de>; Mon, 20 Jul 2020 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGTIhz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jul 2020 04:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTIhy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jul 2020 04:37:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B41C0619D2
        for <cgroups@vger.kernel.org>; Mon, 20 Jul 2020 01:37:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j11so19296872ljo.7
        for <cgroups@vger.kernel.org>; Mon, 20 Jul 2020 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=74/+EzKUAAKlAxACD2N9LwyXc8GIiGB7bIu4cn5OH/s=;
        b=vQVQN9m3LFq9Ac9pxVX05L3jLmD+2U9Pg1NxkoR0om6MN0CgbAArh2CJ12CXyxrFL+
         3IiUGT7KD5izRqhVEEWIKJ1KhzHpmeUgBTXRK4tmYXrW5WPJUyvjKhX8m0dnyhs09+oR
         t1dtcXDwSBOkQvQ/TfJJGBUo92n6DLuwqrJ601PkTy6Od1gF51Bi7eX6vu3TsT7C7PVn
         c/DB1ZpauA4MiBkr0bPc6oMt7vhuCfZqK1rcCXl/s6VT7E7q1kuWtLu+R2y01txevzpH
         8yDU7lAbqd60QD5jlYltL3AAJxoUEeBpsKjJhlFwY2RtgUXj085jYnNnDTfB78cdrtWC
         vmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=74/+EzKUAAKlAxACD2N9LwyXc8GIiGB7bIu4cn5OH/s=;
        b=F/hsz0n5Nzqr1nWzDR/e7r+ARm+WJUS1SCWqaf/EcHK7UofPHO4Gi8AXaG3tD7A3Nu
         1FSAqhdkEe8MyAC2Ab0Z+RdhqZ+PqSj5bpcjfuognRADFHIzccWhbv6BFEM8iTXwvO2m
         r6A6XnwNRkCAH369B/KT7cQnZ7QqVin+6Jei+wPDXN+tmHjI7/835EWSIECjclLbybLG
         1q0Hi3g98L3XoCohkEg+pFADiUxjtV1REapFsLL/GPZvz125or/XbfVqaBzMgH7SiKSb
         QyUzTGjd0Z6XAZG9A3f7VpSRLTrWHbR9xjrfoB0HjfeRBeW7tMqbwgnRd3Bg/JSPbX9s
         O4cA==
X-Gm-Message-State: AOAM530onY009MVa/JUlR7Enw8ih4e/oac/eS+m8ecYujoEP/yGlmqhS
        Y997k8qnyA157r5w4hitlA47gg==
X-Google-Smtp-Source: ABdhPJzvyfql7KnOLFGB+ImTGN6HNKSHcKgVJ1tI3HQEzzu+N7RZLG971Ge+Rm1WAvLpPKPQIT3sww==
X-Received: by 2002:a2e:b6d2:: with SMTP id m18mr9222483ljo.341.1595234272759;
        Mon, 20 Jul 2020 01:37:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 193sm4274310lfa.90.2020.07.20.01.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:37:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 38B47102393; Mon, 20 Jul 2020 11:37:51 +0300 (+03)
Date:   Mon, 20 Jul 2020 11:37:51 +0300
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
Message-ID: <20200720083751.7q4wgmrsefknzwyd@box>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-6-git-send-email-alex.shi@linux.alibaba.com>
 <924c187c-d4cb-4458-9a71-63f79e0a66c8@linux.alibaba.com>
 <20200716131706.h6c5nob4somfmegp@box>
 <045c70c7-e4e4-c1d1-b066-c359ef9f15a5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <045c70c7-e4e4-c1d1-b066-c359ef9f15a5@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 17, 2020 at 01:13:21PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/7/16 下午9:17, Kirill A. Shutemov 写道:
> > On Thu, Jul 16, 2020 at 04:59:48PM +0800, Alex Shi wrote:
> >> Hi Kirill & Matthew,
> >>
> >> Is there any concern from for the THP involved patches?
> > 
> > It is mechanical move. I don't see a problem.
> > 
> 
> Many thanks! Kirill,
> 
> Do you mind to give a reviewed-by?

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
