Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A8232453
	for <lists+cgroups@lfdr.de>; Wed, 29 Jul 2020 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgG2SG2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jul 2020 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgG2SG1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Jul 2020 14:06:27 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F1C0619D2
        for <cgroups@vger.kernel.org>; Wed, 29 Jul 2020 11:06:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e5so4317036qth.5
        for <cgroups@vger.kernel.org>; Wed, 29 Jul 2020 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xJ2kJUaxCqHeFy3eTq7CnXVFURN/g/y8EYUBnKoxbLI=;
        b=Hh5+vEIQvFG8XKYfsn89W1ELEJAteSfSsR7+QmXXZZUAzVy+xvS+g5+YDaaAxrwJ3a
         Ss2XCpv7ku+uVEzhYEqB2q0gAvlwBKp5Pbe311njOHtO5UPoO6Mm2kpPHXLTBYCMwgB6
         05ODjedRN4Wbenc8RzTyzY95fTzbyOdbfmqkWB+/aPn4ARt0yzYImktzJhkK/aAGmbpY
         764Fg81c3gaPBkwzniuvZW3wcT9iWOSntfe75hQK3+oVNT4qOJOFRptI1kJPN1xhHbji
         kjTfGb3pTLdyFPdFooF13n+cVrfdNksjASH9Snfkf+BcLMoo6xgg640CAYbDxCA7kvq3
         VJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xJ2kJUaxCqHeFy3eTq7CnXVFURN/g/y8EYUBnKoxbLI=;
        b=GmV6V5CIoUX1nGXeMbq6jb8gyZab3Uc+JkAqsN/Aswc5hfJITKaO6grYR8QrIIO7QA
         HOKhMvV10OkjPvQSXsD2XRDopCocq28Xm2R4QGobj4Q8TTnmfMmUtkf9DDGeVyNcJTxH
         Qx6Ed6iBAf2kDloUOrL8QkOH8Yt79ueljdanfZKpFSQnkT0yIj3Y3teWGrRM3Y2bpPHI
         HVbLx+pnU051+Lnl4dcTcQzzjJDFqnb4LpN51Mcbno2nwDnhkfBCAVNW3aG77K66F6+c
         cyDOcHoZiEB1hrNSEIja/Q1HRzKBJHYQr4H6Ifat381eyqgx7tGqT1vOSC1Khgp+I10C
         SHkA==
X-Gm-Message-State: AOAM532dBORFFVqH+LXHrgBle+aBRu6GJP5F20mmyUeonmSI9KZhX1yq
        o96NsJyua+IBAACSD4Q3vfALcA==
X-Google-Smtp-Source: ABdhPJzpXzjLsL1qsC1i0J4pQ18httgmazTojrNMLZPYLUJLN/3VPnlQEBNLgHOre+lHSfpnTekbSA==
X-Received: by 2002:ac8:44b9:: with SMTP id a25mr28663335qto.356.1596045986434;
        Wed, 29 Jul 2020 11:06:26 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c7sm1105575qkd.92.2020.07.29.11.06.23
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 29 Jul 2020 11:06:25 -0700 (PDT)
Date:   Wed, 29 Jul 2020 11:06:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
Subject: Re: [PATCH v17 00/21] per memcg lru lock
In-Reply-To: <c00ac587-7f69-768a-84ea-53cbf7469ae9@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2007291105570.4649@eggly.anvils>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com> <49d4f3bf-ccce-3c97-3a4c-f5cefe2d623a@linux.alibaba.com> <c00ac587-7f69-768a-84ea-53cbf7469ae9@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 29 Jul 2020, Alex Shi wrote:
> 
> Is there any comments or suggestion for this patchset?
> Any hints will be very appreciated.

Alex: it is now v5.8-rc7, obviously too late for this patchset to make
v5.9, so I'm currently concentrated on checking some patches headed for
v5.9 (and some bugfix patches of my own that I don't get time to send):
I'll get back to responding on lru_lock in a week or two's time.

Hugh
