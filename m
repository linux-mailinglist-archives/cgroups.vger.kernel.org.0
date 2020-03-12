Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC71837A2
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 18:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgCLRcs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 13:32:48 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39980 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLRcs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 13:32:48 -0400
Received: by mail-wr1-f50.google.com with SMTP id f3so1574415wrw.7
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EMQBFUEliM01ip8eYZWL54ZvB7/WFqSxm3Itb84CtRE=;
        b=k+rsyxmleUdEKNf2d3kL7o7aiIxuTWtLn6o1bdXxge9PXpxV5wPfTKxhslPzkpG0Ar
         G5gSlzvijsb4gXxQfcmGRT1CfQ9MAD/nDqTxMBpLtubU80R8hfLmLGOjuZEo1pkWHAVw
         etC0c1ppz8Vikx3F9E4p63Pul+eZweVNu48ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EMQBFUEliM01ip8eYZWL54ZvB7/WFqSxm3Itb84CtRE=;
        b=gKGg51th4CqvskFGwJSEKmkEe6E0DalTPtHS6FV1YLuYQU4E9w/8qvCg7/23Nof8w3
         F8Cst7Hs+tltnJbMEw8dg7XzsNYdbda0spwwRt4PskGpBNgyF3Pd1FhHJLUbvUXpVwx0
         tMo3XFOV31LddSbB6wqshdqhXW885ymv2JsVMd3MoOe3JmaYyhleuV1MllUNSM3JD3Pd
         sLz1PpUInDKL3sj/cGWE4GzNs7onp7MwfT+WFVqtxikYGW0KjHHjHrEw6kxxxdPvVY5L
         L/c2Gjnzng9YMZPlg8/wtzC+cI+JufoQjONSZ6marIFRxXcgP08IPAEAS+iJ/rAX4rPZ
         DSRA==
X-Gm-Message-State: ANhLgQ0QXosASADMv9YeMcOsbGlpNZ1NGD8reA6ZTUqTSqxFN8d9S4W6
        Sf3uvUNx9Q7XHaVrcEohGgsLJw==
X-Google-Smtp-Source: ADFU+vt8M+ruZvYsAkNQLctYbvXMo4M+2Rv3wILfwgIvL/SQim+R4gGlI7lWWyLUelfDqApMTDzS9w==
X-Received: by 2002:adf:bb81:: with SMTP id q1mr11942344wrg.110.1584034366244;
        Thu, 12 Mar 2020 10:32:46 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id o9sm78936300wrw.20.2020.03.12.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:32:45 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:32:45 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/6] mm, memcg: cgroup v2 tunable load/store tearing fixes
Message-ID: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Chris Down (6):
  mm, memcg: Prevent memory.high load/store tearing
  mm, memcg: Prevent memory.max load tearing
  mm, memcg: Prevent memory.low load/store tearing
  mm, memcg: Prevent memory.min load/store tearing
  mm, memcg: Prevent memory.swap.max load tearing
  mm, memcg: Prevent mem_cgroup_protected store tearing

 mm/memcontrol.c   | 42 ++++++++++++++++++++++--------------------
 mm/page_counter.c | 17 +++++++++++------
 2 files changed, 33 insertions(+), 26 deletions(-)

-- 
2.25.1

