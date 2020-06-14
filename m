Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16A1F89FD
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2020 20:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgFNSKO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Jun 2020 14:10:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46078 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgFNSKO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 14 Jun 2020 14:10:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DAD1E8EE2F6;
        Sun, 14 Jun 2020 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592158213;
        bh=PGzUuMvpO+6kzpKxkF4YyCGT8UrnacuIwBFLYULnNxY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZTx/WKouqrcKstUIGTYH++lQrh1C0vddT233DaDgJcSkoBGuRxjHWqDIv/DCV2FcW
         nmxZCgZRR6oEeitdr/0aMl7UpW1j49vR0+Zg3meoln+8dhpfq3A4cLsfk/NygzMn7C
         HnGpeeSnaN0s4TMWZG+0+02/5SCLxtWvJtDl7X9w=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vUWU89wdzV0W; Sun, 14 Jun 2020 11:10:12 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A61E48EE1C8;
        Sun, 14 Jun 2020 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592158210;
        bh=PGzUuMvpO+6kzpKxkF4YyCGT8UrnacuIwBFLYULnNxY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xYL4fKyr/4K6QtdNcTPoG3uoMbGabnRFHbzYyzXFHR3wXMTTfmYRD96xDZcfODMiZ
         hfE+1jK+tXc3acqPmpkdiIkzYtKkU1746J7RAkLAe3WgsBeWJGBxlnDmFoJpxh0QeN
         LSEibjppD4CsuWup94IIZeRZtJpUGySbDGgoFpf4=
Message-ID: <1592158208.5303.27.camel@HansenPartnership.com>
Subject: Re: [PATCH] cgroup: Refactor two assignments in
 css_task_iter_next_css_set()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     zzuedu2000@163.com, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, songmuchun@bytedance.com,
        buddy.zhang@aliyun.com
Date:   Sun, 14 Jun 2020 11:10:08 -0700
In-Reply-To: <20200614022833.2641-1-zzuedu2000@163.com>
References: <20200614022833.2641-1-zzuedu2000@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, 2020-06-14 at 10:28 +0800, zzuedu2000@163.com wrote:
> From: Wei Fenghai <zzuedu2000@163.com>
> 
> Combine two assignments for the variable ‘l’ into one statement.

The problem with this commit message isn't the description, we can all
see what the change does, it's the justification.  Why is there any
reason to do this?  My version of gcc does this as an optimization
anyway, so the patch doesn't change to the binary output and it's
arguable that having two statements instead of one makes the code
marginally more readable.

Regards,

James

