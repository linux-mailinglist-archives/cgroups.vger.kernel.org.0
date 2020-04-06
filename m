Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46BC19F804
	for <lists+cgroups@lfdr.de>; Mon,  6 Apr 2020 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgDFOeI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Apr 2020 10:34:08 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:33082 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgDFOeI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Apr 2020 10:34:08 -0400
Received: by mail-qk1-f177.google.com with SMTP id v7so16385526qkc.0;
        Mon, 06 Apr 2020 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8+jcnJTXIga9mkqHp3/5JxbQM57y376bXrCDo/ExKrY=;
        b=dGSTYEP5uA6qHfprtplk07U7wkOAEHGJIx4v6hfun7FO8q6S6D4pwPBnwLsU3pP83Y
         JZRw7+elch1nmfQtGY+9kSnNbjXh6McBm/e0fx3RrW/Osv8pWY9B+UyxwbQMZVjKUIKn
         FCqsUYZN5mh4h5E4WJw0K3zdisDMMN8hRPTwSPFBkRhVz1oWIlVYDmfqolDvjEo5ppQa
         jm8M7Kv6g59A7GbX/bJu7CkDzV4nF7paMpVPLN1O0oR70Ama+MZqxv8mXPJcMGPVD41y
         TXGyslkyDXnz9ABZ99vOb6Byf+vqCpYWwyNK8YGoaWBzygjeJcgfmoth8ZeMTH4hY7a9
         6E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8+jcnJTXIga9mkqHp3/5JxbQM57y376bXrCDo/ExKrY=;
        b=FY+UMa/K6JsUCk/WjfnHFRu9f1EbN5z/YGVCEWrTnFd18eT7Wx4lsFqgkItR3UTbOz
         NdoaDA2QHtlO2jY3mGDhUdaNyHy0NiBWjQ9z3xDNEu5E5BL1TyCwVMl13zjPmMeWiCZT
         BkbuNR4K+bNHmtEpw9jl52eP8mHRv5gCRCBZB7t3p02fJB5+cwDsTc9llWNMtg3JBY4X
         MtnkNv1l1ctasR58whtcmbiY3QXkiCbaHjb7jy45eb3WUQYmJSc5VpRaF9fw10EII0nO
         LFOvoIXvF0QRGnuOePIg1V7TxcK1n2iI0F3ceZYtV7pKyJtXpB46hpZaDAK9QzKebtBo
         G2lQ==
X-Gm-Message-State: AGi0Pua4KvStMBXucpeanOwiggqkCqUSYJSDQ6nC+V+f+6pr/n9msUih
        6jaKIzEhc+STc0t4C62ED90=
X-Google-Smtp-Source: APiQypIl/HBxvhFRvUyRCeNhpPwhQbDSrDTvcnmU7hn232XoQYm2bs0nS7YDyfB6VylVGCsrdlc++g==
X-Received: by 2002:ae9:c312:: with SMTP id n18mr20722643qkg.472.1586183646991;
        Mon, 06 Apr 2020 07:34:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::eeba])
        by smtp.gmail.com with ESMTPSA id m5sm13539502qtk.85.2020.04.06.07.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:34:06 -0700 (PDT)
Date:   Mon, 6 Apr 2020 10:34:05 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Qian Cai <cai@lca.pw>, Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-ID: <20200406143405.GH162390@mtj.duckdns.org>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
 <20200326101529.xh763j5frq2r7mqv@e107158-lin>
 <20200403145523.GC162390@mtj.duckdns.org>
 <20200406105522.c66p4vzzzylety5d@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406105522.c66p4vzzzylety5d@e107158-lin.cambridge.arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 06, 2020 at 11:55:23AM +0100, Qais Yousef wrote:
> What would be the right approach to get a fix in then? We have been skipping
> this test for a while and we'd like to enable it but this failure is a
> blocking issue.

Update the test so that it accounts for the async nature of the operation?

-- 
tejun
