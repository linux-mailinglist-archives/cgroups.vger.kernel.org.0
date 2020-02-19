Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F51F164934
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgBSPwF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 10:52:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39835 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgBSPwF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 10:52:05 -0500
Received: by mail-qt1-f194.google.com with SMTP id c5so529740qtj.6;
        Wed, 19 Feb 2020 07:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fFVDMYCiG2Jj7QSlhcVZE7ZVXQws5yCHBTafyc8gAf0=;
        b=Qkf7uJ1c4rV5Qm1v9FuRvQTyPOE0LdHlD1+++LZmhiqhFLAYLJCJQYulwn5mGbVQSQ
         b93pgugYT/+zQWagehceyEAvjfr1/EXp/YZpqn3v0IJ1ru89mZ3VSjJS6GRX/FI9LJCe
         XB0ajQwGjX/snUDFYuq61rJEPhUPxutyuiw8s3DOs6i/EgCsMkd4HnJsxkztYM9Me6sx
         9o5BLcIFLyBJNWmV3BNFtO7yrg1L1MEmQ31pETajfSjjFWOV9MPZ54G3lgfVDbpSuNWK
         DqTsVYB/R3ez5ZLWy+GAX7MGLOc4sP/o+7xmXydKDgRpRW3B24yugdxMlZlSWMa/UEEc
         BdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fFVDMYCiG2Jj7QSlhcVZE7ZVXQws5yCHBTafyc8gAf0=;
        b=EVPpXADiSU17GnrSF9wqICCl5gO2Jo43CqQ788plpVa0QWZxfU4z1H2nW7FUx5jEnj
         OFd7HCx+DjZMx71JynIWUxdH3wiDmQC3YvG5AK0xQPZYgxfKbi4ic+OwkZWP9atXRYFK
         MIAxTwczsbguX5/lenVsWD4bJy3BoTaAWgu9bn7Kn5JweUgxXVilAz7o/UXV4K3VEa6l
         NOcYAQSst8tGEsAeUajKMnjQUKz+K0s+wbaqFw97wvWrBnCN/VRWUGfTOcFWcfUjcKA5
         LqHwIJH7DKEKAUq/lq9fqbnRmMN6G1/fe7G7RZdaYOLQ0N+vW9iKGqAj86TJGmGwSfd6
         ecfQ==
X-Gm-Message-State: APjAAAUMr7JiayCnuc9fjHlISyQqwqoBFH+PH7J+6ss7YqAAhTDJ1JxD
        l18OQXE+VUg6D0JxlyE1++I=
X-Google-Smtp-Source: APXvYqxggCQfBsIJiialGvH6QEFJhXGEsvlvNLXoHwPOUf5pBk2TNNO+hRO+6MpcmvMYFZn6dKUAow==
X-Received: by 2002:ac8:4410:: with SMTP id j16mr22707290qtn.261.1582127523849;
        Wed, 19 Feb 2020 07:52:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:e7ce])
        by smtp.gmail.com with ESMTPSA id c52sm197292qtb.16.2020.02.19.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:52:03 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:52:02 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
Message-ID: <20200219155202.GE698990@mtj.thefacebook.com>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
 <1317969050.4131.1581955387909.JavaMail.zimbra@efficios.com>
 <20200219151922.GB698990@mtj.thefacebook.com>
 <1589496945.670.1582126985824.JavaMail.zimbra@efficios.com>
 <20200219154740.GD698990@mtj.thefacebook.com>
 <59426509.702.1582127435733.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59426509.702.1582127435733.JavaMail.zimbra@efficios.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 10:50:35AM -0500, Mathieu Desnoyers wrote:
> I can look into figuring out the commit introducing this issue, which I
> suspect will be close to the introduction of CONFIG_CPUSET into the
> kernel (which was ages ago). I'll check and let you know.

Oh, yeah, I'm pretty sure it goes way back. I don't think tracking
that down would be necessary. I was just wondering whether it was a
recent change because you said it was a regression.

-- 
tejun
