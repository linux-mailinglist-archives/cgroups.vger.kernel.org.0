Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5B3CCD9
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2019 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390706AbfFKNZm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jun 2019 09:25:42 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:37081 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbfFKNZm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jun 2019 09:25:42 -0400
Received: by mail-pg1-f181.google.com with SMTP id 20so6988825pgr.4;
        Tue, 11 Jun 2019 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z3SVKPRw9ZtZpo81aZhS+cQGKdAzxZJguviRIBAK0b4=;
        b=hkx2GURtFLnpgApzKLSXJXyEaJj/ziUqazQEkyPie9Mnwpy4xHumI5UUcVe5mQza0b
         lKH388U00jEmGYS0jIwaGGYpjrprh72VY+OnyINgSvTUXaYlPdxS3mj1Vjren5hcpCiD
         3j69a1dFIzq97phFF0iX9sgjkxwfs7m0o4FGmtMxhv+XGKm8J33kSmuSDw+sq+oH1w6s
         SMmnaIOnv18Yq9M2kVkkdawBKUmOD5mewX4Wtlupss724qP3FdnyRFlv27hqw6Ws5qRv
         VnLC7hoeVOXhKmqAII4wOKn1Kn7GOHXop+dfFC0bDzxYLkV4InOdMxh3fhEFg8UmkxZf
         /ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z3SVKPRw9ZtZpo81aZhS+cQGKdAzxZJguviRIBAK0b4=;
        b=OJ3gGoZNcxQgaUxgsVjSnVuMShJlMa9JxQwoyvmxz+s/Pd3TGThETHAHlvuZeNrdkP
         J3CA0HdDCIHOsOoFMSKPFnkVj6CBOO2oNGDVcoAE9ftI/6k0affsEE0dQhEJlj7qHjCr
         wbXZUc82nr5D5/E/aNG6k5PcjTVmOSP7lODVi4cC/wI4Z1xcimNSQXcR9nfX/TaRPSzL
         HLmnjR7YLtRLddxyjWBAirF4EnLzVIi1bCbr4GkgLAeWVXP/7T6ReqGD50/JEjh5wsPj
         VcMnD/9VRyt7U9actKN134Gx4L2lOXgnAuv0+P6jlqBUCu5B6efX2FL5WXnmuqOaO65E
         932Q==
X-Gm-Message-State: APjAAAUKm9WWRriF2FePqCHCMjcNAzVABaxF22jKQOhwql/ap8HtkIAx
        XV/r8esiGPcuWGooWEuE0bo=
X-Google-Smtp-Source: APXvYqzfHAwVPoBeu6L7A6Wles5wPTy689onnibJXlJpjtnK/lBBERnuRNp3cG0NgCtiqlq1Zmqwgg==
X-Received: by 2002:a17:90a:b94c:: with SMTP id f12mr26529322pjw.64.1560259541181;
        Tue, 11 Jun 2019 06:25:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:1677])
        by smtp.gmail.com with ESMTPSA id o6sm14173077pfo.164.2019.06.11.06.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 06:25:40 -0700 (PDT)
Date:   Tue, 11 Jun 2019 06:25:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au
Subject: Re: -next-20190607 kernel: oopses on bootup or shutdown
Message-ID: <20190611132536.GE3341036@devbig004.ftw2.facebook.com>
References: <20190611085753.GA12364@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611085753.GA12364@amd>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 11, 2019 at 10:57:53AM +0200, Pavel Machek wrote:
> Hi!
> 
> It failed to boot three times; now it booted but failed on shutdown.
> 
> Hardware is thinkpad X60 (32bit x86), and I'm copying oops by hand.

Can you please try next-20190611?  It should be fixed now.

Thanks.

-- 
tejun
