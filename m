Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9380E18E63
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEIQsG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 12:48:06 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34700 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIQsG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 May 2019 12:48:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id n68so1887769qka.1
        for <cgroups@vger.kernel.org>; Thu, 09 May 2019 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LnyOr6ZjvYu5ZxnoPdE4jqzxN1EqnDnnop6FdcNjWUo=;
        b=WtlE+P3HplSNzxMK41/9RDh/agT6ECvTArx0nyXfmTrqPeHrI1dlhmlFbPSfGkf1XZ
         EYVC00Ie/P5VHI9oUnao//YW5RN8bj/xIucPH7Q/LYeBAdXtCUCS/XxnY7WS+mq9dW2i
         5lwvj7qHtwSwBTEOzvM2SvOlykhHzpReUEhhvVvxi0Hfp2iyuYjfZAWqy7XHNGKTYO+H
         YAyFa3LhmBg1NdPHNsxPtPyrL2XMHNUoFsOsh2HSY1Cgn+dtXhVzNfcMhhrJyrnofCCa
         ZvZOw4hQFIjgJEZjHFxoAk1Ys0ZUq4sSZLUgfd31jwkZmUizT8dr7fLkoPKDGCXNyHpL
         V+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LnyOr6ZjvYu5ZxnoPdE4jqzxN1EqnDnnop6FdcNjWUo=;
        b=a5m5uCnhCwiQ3GxXskdueLGGNoNwBHI03h72vrnLtElGI/39jpErSZvXbtaplZPq0X
         Eyb+4+bjJfdJ62x3GqgFmaqxjZIoWjiSAyZWt2VbGMp5KnxkjDAElsDtMp0McdENZooj
         5G+NE3P75tXV1PCFD0uVl4ugtvskfvlh9NLL2EQfX18NpGGKH6hpg/o6vTXHSINC4Yd3
         1iqZnvoVTyNbqM6ZSQhThdxRacOD4sQrUmNKwciE61bX2EE8dCuvgzM54ErlP5XHKxR7
         cTMFsMeuIoH+5ygBtB5ac7LFXS2G8QTUcISum3XsM+F3VI7ftA66wFmcsLIr/OJNyobp
         w4FQ==
X-Gm-Message-State: APjAAAX10JggvNxNQjRovqkeXfv52grl7ig8mzlnn7yaXkOOsM1cDR26
        NXq5Vc5LcfGphHm7qgSGYJNiddqc0wE=
X-Google-Smtp-Source: APXvYqxj1UpguRUHZlnsD2pdtF8y8Y6jpDdLG+5qOZpB2lOkj/swrowMpce7P5mkPHFxmjEnZklzJQ==
X-Received: by 2002:ae9:df44:: with SMTP id t65mr4225788qkf.126.1557420485515;
        Thu, 09 May 2019 09:48:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c346])
        by smtp.gmail.com with ESMTPSA id m31sm1466763qtm.46.2019.05.09.09.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:48:04 -0700 (PDT)
Date:   Thu, 9 May 2019 09:48:02 -0700
From:   Tejun Heo <tj@kernel.org>
To:     zhangliguang <zhangliguang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] fs/writeback: Attach inode's wb to root if needed
Message-ID: <20190509164802.GV374014@devbig004.ftw2.facebook.com>
References: <1557389033-39649-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557389033-39649-1-git-send-email-zhangliguang@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, May 09, 2019 at 04:03:53PM +0800, zhangliguang wrote:
> There might have tons of files queued in the writeback, awaiting for
> writing back. Unfortunately, the writeback's cgroup has been dead. In
> this case, we reassociate the inode with another writeback cgroup, but
> we possibly can't because the writeback associated with the dead cgroup
> is the only valid one. In this case, the new writeback is allocated,
> initialized and associated with the inode. It causes unnecessary high
> system load and latency.
> 
> This fixes the issue by enforce moving the inode to root cgroup when the
> previous binding cgroup becomes dead. With it, no more unnecessary
> writebacks are created, populated and the system load decreased by about
> 6x in the online service we encounted:
>     Without the patch: about 30% system load
>     With the patch:    about  5% system load

Can you please describe the scenario with more details?  I'm having a
bit of hard time understanding the amount of cpu cycles being
consumed.

Thanks.

-- 
tejun
