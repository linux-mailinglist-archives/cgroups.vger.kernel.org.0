Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70ACB2CF00
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfE1S4J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 14:56:09 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40272 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1S4J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 14:56:09 -0400
Received: by mail-ua1-f67.google.com with SMTP id d4so8407041uaj.7;
        Tue, 28 May 2019 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u2vKrC8e8AnG7bW+4DZ/V1meRc4PDbuorAeJTymG4Y4=;
        b=MDDiuEPMelHkgMWgSKYRjyQIeWD/ouruSjU4ACu7p/oJ3WTucAZTAQsz4i0JBvHCz1
         U5bSfL8BGzOaayfxj/G8Dk6zcicsyVBkvChN0PAml3EQeIgZrLjLabjZfhVVkh4Wm6Ag
         wDSiY9MjhZpjYf4gmwpQPUB4DFl+UT4abMHcCs/z3cTwOHc1pW8dFN4CDwAgxfJhY5BL
         nakw6hcsyZd8q3IHOM4pT/7/uifEFp4e7Dxp8Vps7C1iJ4EBdAjSRQGbnhyimXT6oEW0
         oW9hmHm25wWRaMLvSuO0f5zabJ3bP4pnme1aAwVOjOToyv24g4tFlzTu+GPr3QWLbzQe
         brhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u2vKrC8e8AnG7bW+4DZ/V1meRc4PDbuorAeJTymG4Y4=;
        b=nW+vnDTzvVQECXqV4m3KbSHF5USc9PWpSgu48eOxyYzqcbC3lV2eRGft14vv480yUM
         KyfzeZwLxpVsm/ZEBDyk0p1/6WTzPt22KSA/4pY99US3uEO7iTjOi4m/ige/st56T1+J
         fH7v1u2GhHq1fMLYQDW3ZLGxrVuLHC7vrLvHKchSmYTG4P89d3psYzPjT86tf06OofeI
         USL6TNUR+hZLs56AEOPDBQPfbenWLgmIwWVhbO4eptL2/Az7MCELLO1rhPb/ausDsdr2
         Re7Lnu62MPj/3/5YRwrjlIqsa5OKAzBbd7WdOeP5b4+gQhKxPvtqPPloKfIjFCuJnJvH
         al4w==
X-Gm-Message-State: APjAAAWYRU4pxRHBbRUp6zMaaKTix1ZxT7bqpxWnY4QANKQI0kRtVw/j
        Dj+TNbHfGsEyxZdXam4dTrpjS+XU
X-Google-Smtp-Source: APXvYqwFIHYU1zkbjqQF9k9xbYRzbj5CJgL7vB1Yw2YhYWmz9NNxvoWn9yqgWy2L12eun7GGNxhmDQ==
X-Received: by 2002:ab0:806:: with SMTP id a6mr43288984uaf.10.1559069767987;
        Tue, 28 May 2019 11:56:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:d74f])
        by smtp.gmail.com with ESMTPSA id k82sm9413128vkk.12.2019.05.28.11.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:56:06 -0700 (PDT)
Date:   Tue, 28 May 2019 11:56:04 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Xuehan Xu <xxhdx1985126@gmail.com>
Cc:     ceph-devel <ceph-devel@vger.kernel.org>,
        "Yan, Zheng" <ukernel@gmail.com>, cgroups@vger.kernel.org,
        Xuehan Xu <xuxuehan@360.cn>
Subject: Re: [PATCH] cgroup: add a new group controller for cephfs
Message-ID: <20190528185604.GK374014@devbig004.ftw2.facebook.com>
References: <20190523064412.31498-1-xxhdx1985126@gmail.com>
 <20190524214855.GJ374014@devbig004.ftw2.facebook.com>
 <CAJACTueLKEBkuquf989dveBnd5cOknf7LvB+fg+9PyjDw1VX6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJACTueLKEBkuquf989dveBnd5cOknf7LvB+fg+9PyjDw1VX6g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sat, May 25, 2019 at 01:03:56PM +0800, Xuehan Xu wrote:
> However, Ilya Dryomov pointed out, in another thread in the mailing
> list ceph-devel, that the blkio controller is supposed to handle any
> io now. We now think maybe we should try to leverage the blkio
> controller to implement the cephfs io limiting mechanism. Am I right
> about this? Thanks:-)

Hmmm... io.latency works only if the IOs pass through a request_queue.
Given the transport is network, would it make more sense to control
from network side?

Thanks.

-- 
tejun
