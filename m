Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C511085312
	for <lists+cgroups@lfdr.de>; Wed,  7 Aug 2019 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbfHGSkx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Aug 2019 14:40:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45808 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388612AbfHGSkx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Aug 2019 14:40:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so15999579qtp.12;
        Wed, 07 Aug 2019 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G/k7GjX7actKY3ZvBhXdU3H/Qr3MiRhENkA6l010uvs=;
        b=LYvjXlm2BFEjDPmfW8e/+v5eAaXWtqMFvTIXCTr/2Dcj3s8L/diONyZq6DkHlabtdB
         tlSCUvvAl0aErFOwrmUS/ojOMX+xf35thBmmsjwWUZ2CIvx2GIO0RV+POFBh1BcT67/j
         ElLjBgNW1YuZ5CQz73fCLLw2Bf4XJgegV0xVCu6HSLb30f2xR7Te9pNFu0LOap9vj7/F
         E6X9iPLWjuz+gs0fKtQO3TYOxmgyv2UPzUEf2s84xxZzGtCOmqWBT+kkZ+EDJzZPVnKY
         VM9A+vCmfxpAyFsJXPiXgh5/siHQAAle7TSplwahn16dqsW1XsMWnaOvdeOwU1v+n5l6
         wPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G/k7GjX7actKY3ZvBhXdU3H/Qr3MiRhENkA6l010uvs=;
        b=HCazLg6DdSBDVD3AXwu/doQuH4LCAqCnkYS7/552TBWfHNGcTBH7jbnEYU7VYbG7E1
         wVC+rFsaeuVonZFEHvkdT0sYTOH4ACGtbPCItxoaDOQkDn9YHzq7Yw9FGe3Duv7BELhV
         RVb7OjvDFBKVynTwPpwy1Lzs3h89HFJ5NGTYAQ4rBWjDqFv1hCAUbQFnMLaMjVZ2BS4o
         DsP5Y/2zJwWW7xmlE8u+xmHMe0HBWZun5iBpFZuS0r7+V0M13ihSJOpZJzmxf/D0W5Fc
         h5VK8+FT+Y+E4E4DQjkV1C0wLKQdicXgFI7nmZjlvVVZhK4j0fH3By/H9c55IjfITyBf
         DoTw==
X-Gm-Message-State: APjAAAXdu48tdn1y4WYWbrEe17Wzk2o24InuHtxNwRzweEt5EDrHTMbH
        zOamdW+OuIo4NKTAN5TZyD0=
X-Google-Smtp-Source: APXvYqzvJeLYNaljhRCjXflpoXguQRhx7Iy1pG96ylBcv2F+KfLQm1mDfVkIiPK1zQaP+KxuftvCOA==
X-Received: by 2002:a0c:d09c:: with SMTP id z28mr9520059qvg.149.1565203252465;
        Wed, 07 Aug 2019 11:40:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::6ac7])
        by smtp.gmail.com with ESMTPSA id c5sm41870256qkb.41.2019.08.07.11.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 11:40:51 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:40:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Marc Koderer <marc@koderer.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use kvmalloc in cgroups-v1
Message-ID: <20190807184050.GO136335@devbig004.ftw2.facebook.com>
References: <20190806132412.92945-1-marc@koderer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806132412.92945-1-marc@koderer.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 06, 2019 at 03:24:12PM +0200, Marc Koderer wrote:
> Instead of using its own logic for k-/vmalloc rely on
> kvmalloc which is actually doing quite the same.
> 
> Signed-off-by: Marc Koderer <marc@koderer.com>

Applied to cgroup/for-5.4.

Thanks.

-- 
tejun
