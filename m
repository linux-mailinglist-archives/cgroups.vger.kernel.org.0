Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D90E82411
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2019 19:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfHERgS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Aug 2019 13:36:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43688 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHERgR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Aug 2019 13:36:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so35024634qka.10
        for <cgroups@vger.kernel.org>; Mon, 05 Aug 2019 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k2mcF+UO8Yy/u7bbXgzcFfvXrdf6fZM9AL+8liZaT9M=;
        b=NF7IBwD/JqzzNGXoQSj8Hmq6qhA7vqm0V9nYXsSEdOiMdok8+nIHu5pwjNxqRH7uKM
         PIjX6C4Fl0Rcr7b7bIr7JfXucVpc+4rk0InS5gc0eHg1ZwCWSyRgqFfKs5cWp6QmaiNE
         AWkAXzdxL24YhEBu26bOUEx/nORFOQLU0artjVhGzAcaez8+V8fHESdSASPzz8aVB7RA
         ZkD1GRgvw/k8f019NeZ0PJBtJ0mN3iLvpewFHSGSt5YQjcC83VSolsFa2Zt7MfthJW9L
         MejWSJTMPH2CfqAXJio5xSeHd4ManMJksm40+lmnCSgLakMw3rykjGz0JYbz6BPh6TXx
         5xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k2mcF+UO8Yy/u7bbXgzcFfvXrdf6fZM9AL+8liZaT9M=;
        b=W9ZJ4NoV8Pv+QN2EFxDK26s6HnRhi6rdexPODWldFcLnhxgYmGvFCOAf2r9o2tdCWq
         h/bk3sxqptdZffEsTMJGvFOpiKHfhKcy53nF17a6f93av7iL+vW6YO028IHx25sykQnN
         rUObVRoErW5YW9Dpwg4QwjsQIawKipBwIOq2U1OIIkYv34jK0A1Pqln6NkLNySIc7rdS
         9IwQ3Vl5kjwK1e59zTKl+zCHoS7MGN+F4rFfV8l0yRWFUAedTVMCyvmGN3M6dThV+1ql
         Mm9kNqsxa+6KlqmNT9x5uOJJjprCmOEp8LgN1dxpd8RiYGjbBIZkpfevH16+Ooimz6WZ
         zzAw==
X-Gm-Message-State: APjAAAWSeeLKOQ4tCRLLSm3xinXwrlyXwjWxFSjmS0y8rYsfZHAKmLuB
        3kqjWnU9+AJ4VmcbDCv0apE=
X-Google-Smtp-Source: APXvYqw6I5lhIUqMHRxgV23Ht0ERxvg1TXKldhQ8zR86feJr7J8oGoC63/GDMhPP/J003WA+iXVVuQ==
X-Received: by 2002:a37:62ca:: with SMTP id w193mr60716676qkb.363.1565026576828;
        Mon, 05 Aug 2019 10:36:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::39f3])
        by smtp.gmail.com with ESMTPSA id r205sm41417209qke.115.2019.08.05.10.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:36:16 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:36:14 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Li Zefan <lizefan@huawei.com>, Topi Miettinen <toiwoton@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, security@debian.org,
        Lennart Poettering <lennart@poettering.net>,
        security@kernel.org
Subject: Re: [PATCH 5/3 cgroup/for-5.2-fixes] cgroup: Fix
 css_task_iter_advance_css_set() cset skip condition
Message-ID: <20190805173614.GG136335@devbig004.ftw2.facebook.com>
References: <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190530183845.GU374014@devbig004.ftw2.facebook.com>
 <20190531174028.GG374014@devbig004.ftw2.facebook.com>
 <20190605170333.GQ374014@devbig004.ftw2.facebook.com>
 <20190610161619.GB3341036@devbig004.ftw2.facebook.com>
 <20190802075709.GH26174@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802075709.GH26174@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Greg.

On Fri, Aug 02, 2019 at 09:57:09AM +0200, Greg KH wrote:
> These all made it into 5.2 now.  Should they also be backported to 4.19
> and/or any older stable kernels?

Yeah, I guess it should have seen enough exposure now.  I think it
makes sense to backport them given the screwy failure mode it fixes.

Thanks.

-- 
tejun
